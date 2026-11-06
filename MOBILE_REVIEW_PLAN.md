# `,mobile-review` — code review on the Android tablet (design + status)

**Status: implemented** (steps 1–9 below). Usage docs live in `my_scripts/README.md`; this file records the
design, the decisions and why, and what is left.

## Goal

One command that turns something I want to review into a tablet-friendly file and drops it,
timestamp-prefixed, into `~/Sync/Mobile/00_review/` (a Syncthing folder, auto-synced to the tablet).
Tig and lazygit get a keybinding for commit diffs, like the existing diffnav `D`/`B` bindings.

## Command interface

`my_scripts/,mobile-review` — Ruby, global-mise shebang (`#!/usr/bin/env -S ,mise-global-exec ruby`),
no extension, comma prefix. Three subcommands, one per input type, plus an **implicit mode**: with no
subcommand each argument is classified by extension (`.md`/`.markdown` → `md`; `.pdf` and images → plain copy
with the timestamp prefix; anything else, or a missing file, is an error pointing to `files`). Inputs can be
mixed and each produces its own output; `--name` needs a single input; everything is validated before anything is
written. `,mobile-review notes.md other.md` therefore replaces `,mobile-review md ...` (still accepted).
Images: png jpg jpeg gif webp svg bmp avif heic heif.

| Subcommand | Input | Output in `00_review/` |
|---|---|---|
| `md FILE...` (or just `FILE...`) | markdown file(s), one output each | `<ts>_<name>.html` (self-contained), or `.pdf` with `--pdf` |
| `files PATH...` | files/dirs | folder `<ts>_<name>/` with the files copied as is, no conversion (`.git/` skipped) |
| `diff SELECTOR` | git diff | folder `<ts>_<name>/`: `00_diff.html` (or `.pdf`) + the rendered markdown files of the diff, see below |

`diff` selectors: `--commit REV` (message + diff; merges diff against the first parent), `--range A...B`
(everything B adds relative to A; header lists the commits, one combined diff), `--working` (`git diff HEAD`),
`-` (unified diff on stdin).

Common flags: `-n/--simulate` (dry run, repo convention), `--name NAME`, `--pdf`, `--dest DIR`
(default `$MOBILE_REVIEW_DIR`, else `~/Sync/Mobile/00_review`). Prints the written path; exits non-zero if the
destination folder does not exist (it never creates a folder outside Syncthing; the check runs before any
conversion).

**Partial files and Syncthing.** Syncthing does *not* ignore `.part` or other hidden names by default (the
Syncthing folder here is `~/Sync/Mobile`, no `.stignore`; fs watcher 10 s, rescan 1 h). Its scanner does skip its
own temp-file name `.syncthing.<name>.tmp`, so every output file is written under that name and renamed when
complete. Checked end to end against the running Syncthing 1.27 through its REST API (`/rest/db/scan` +
`/rest/db/file`, with a normal file as positive control): a temp-named **file** is not indexed, also inside a
normal folder; a temp-named **directory** is not indexed itself, **but the files inside it are**. So folders
cannot be staged under a temp name: the final folder is created at once and filled file by file (each file
atomically, `00_diff.*` last). The tablet may briefly see a partly filled folder, never a partial file.
(Alternative if that ever matters: stage on the same filesystem outside the Syncthing folder root and
`rename` the whole folder into place.)

Filename: `YYMMDDHHMM_<name>[.ext]` — two-digit year, e.g. `2611061219` = 2026-11-06 12:19 (minute resolution,
so `-2`, `-3` is appended when the same name is sent twice within a minute; still sorts chronologically).
PDFs and images keep their basename and (lower-cased) extension.
Default names: md → file basename; files → first basename (`_+N` for N more); diff → `<repo>_<shortsha>`,
`<repo>_<a>-vs-<b>` or `<repo>_working`.

Small behaviours added while wiring the keybindings: tig's all-zero object id (its "Unstaged/Untracked changes"
rows) is treated as `--working`, and `main...X` falls back to `master...X` (and vice versa) when the named
base branch does not exist.

## How each type is built

### md
`,mobile-review` loads the `,md-to-html` converter class in-process (like `,md-to-pdf` does) with
`inline_images: true, prerender_mermaid: true`:

- `,md-to-html -i/--inline-images` embeds local images as base64 `data:` URIs. Without it, relative image
  paths are rewritten to absolute filesystem paths, which are broken once the file lands on the tablet.
- `,md-to-html -m/--prerender-mermaid` renders Mermaid to inline SVG with `mmdc` and omits the CDN script.
  By default Mermaid is rendered client-side from a jsdelivr CDN, i.e. broken offline. The rendering code
  moved from `,md-to-pdf` into the `,md-to-html` base class and is shared.
- PlantUML is always pre-rendered to inline SVG.
- `--pdf` uses `,md-to-pdf` (Puppeteer, A4).

### files
A timestamped folder with the given files copied as they are, paths kept relative to their common parent
(never an absolute home path), `.git/` skipped, symlinks followed and stored as regular files. No `zip` (dropped:
Syncthing syncs folders fine, and the tablet can browse a folder without unpacking anything).

### diff → folder (diff page + rendered markdown)
Output is a folder `<ts>_<name>/` (not a single file):

- `00_diff.html` (`00_diff.pdf` with `--pdf`) — the diff page, designed below; the `00_` prefix sorts it first.
- One rendered version (`<name>.html` / `.pdf`) per **markdown file added, modified or renamed** in the diff
  (`.md`/`.markdown`; deleted files are skipped), same rendering as the `md` subcommand (inline images,
  pre-rendered Mermaid).
- **The markdown is the version at the diff's last commit** — `--commit REV`: REV; `--range A...B`: B (the tip);
  `--working`: the working tree (the diff itself is working-tree vs HEAD). For commit/range the file is read with
  `git show REV:path` into a temp tree, together with the local images and `<!-- include: -->` files it references
  (also as of REV), so `,md-to-html` resolves them exactly as they were then; later working-tree edits never
  leak in. `diff -` (stdin) has no repo, so no markdown files.
- Names: basename without the markdown extension; if two files share a basename, `<dir>__<name>` for the
  colliding ones (flat folder, no clobbering). A markdown file that fails to render is skipped with a warning;
  the diff and the other files are still delivered.
- **Links between the rendered files** are rewritten (`rewrite_md_links`): `<a href="other.md#a">` (relative to the
  file, or GitLab-style `/root/relative`; percent-encoding and `?query` tolerated) becomes `other.html#a` when
  `other.md` is in the same folder (HTML mode only); links to files outside the folder, external URLs, anchors and
  images are untouched. The diff page gets a **Rendered ↗** button in the header of each such file (config key
  `rendered`: repo path -> sibling file name; `.pdf` names in PDF mode).
- **`--working` includes untracked files**: `git diff HEAD` skips them, so each one from
  `git ls-files --others --exclude-standard` is appended as a new-file diff (`git diff --no-index /dev/null file`);
  files over 1 MB are skipped and counted in the page header; they become markdown renders / language hints like any
  other file.
- Header paths: git is called with `--src-prefix=a/ --dst-prefix=b/` because `diff.mnemonicPrefix` in the user's
  config (`c/`, `w/`) otherwise changes the headers; the header parser also accepts any one-letter prefix, so
  piped diffs work.

#### The diff page
Constraints: **self-contained** (tablet may be offline), readable in portrait *and* landscape, wrap, split
view, syntax highlighting, a nice monospace font. First version used `diff2html-cli` output as is; tablet
feedback ("ugly fonts, no wrap, no side by side, want syntax highlight") led to the current design:

- **No CLI subprocess.** `my_scripts/lib/mobile-review/diff-viewer.html` is a template that `,mobile-review`
  fills with: diff2html's `diff2html-ui.min.js` (the *full* bundle, ~1 MB, because the "slim" one the CLI
  uses has no highlight.js), `diff2html.min.css`, the highlight.js `github` + `github-dark` themes (GitHub
  light/dark; follows `prefers-color-scheme`), an Iosevka subset, the raw patch as JSON and the commit header.
  `diff2html-cli` is still what gets installed (via mise), but only as the source of those bundles; they are
  located relative to its binary (mise's isolated `node_modules/.mise/<pkg>@<ver>/` layout or a flat one).
- **Rendered in the browser**, which makes **Unified/Split** switchable inside one file. Sticky toolbar:
  `Unified | Split`, `Wrap` (default on), `A− / A+`. Split is the default when the viewport is ≥ 900 px wide
  (landscape tablet), Unified otherwise. Choices persist in `localStorage` (guarded by try/catch).
- **Font:** Iosevka (`lib/mobile-review/fonts/`, Latin + punctuation + arrows + box drawing, ~26 KB per weight
  as woff2, SIL OFL licence included). Ligatures are disabled so `->` / `!=` read literally.
- **Syntax highlighting in both layouts.** diff2html only maps file *extensions*, and most of `my_scripts/` has
  none. `,mobile-review` reads each extensionless file's first line (`git show REV:path`, the range tip, or the
  working tree) and passes shebang → language hints; the page also knows common dotfile names and falls back
  to a `#!` line visible in the diff, then sets `data-lang` per file before `highlightCode()`.
- **PDF** (`--pdf`): the same page with a `{print: true}` config (unified, wrapped, 11 px, no toolbar), A4
  `@page`, printed by headless Chromium (`chromium`/`chromium-browser`/`google-chrome`; clear error if none).
  PDF is the better format for annotating on the tablet, HTML for reading and zooming.
- `git` is run with `--no-ext-diff --no-color` so user diff drivers cannot interfere; an empty diff is an error.
- Rejected: `delta` (no HTML output), ANSI→HTML converters (static width, no toggles, `aha` not installed),
  Monaco (multi-MB bundle), CodeMirror merge view (needs a bundler + old/new file contents; the fallback if
  this page ever feels cramped), the diffy.org upload flag of diff2html-cli (`-u`, uploads the diff — never use).
- Size/perf: ~1.1 MB per page (mostly the highlight.js-carrying UI bundle); a 39-file / 1.3 MB range diff
  renders in ~1–2 s on the laptop (expect several times slower on a tablet).

## Dependencies

- `diff2html-cli` via the global mise config (`"npm:diff2html-cli" = "latest"` in `mise.toml`, which is
  symlinked to `~/.config/mise/config.toml`). `,__install_requirements.sh` installs it only if the
  `diff2html` command is missing and never upgrades it.
- Same as the md pipeline otherwise (ruby, node, commonmarker, mermaid-cli, PlantUML);
  chromium for `diff --pdf`.

## Keybindings

`M` was rejected: tig binds it in the status view (mergetool; meld is the configured mergetool) and lazygit in
the files/branches views. Chosen keys, checked against tig's shipped manual and lazygit 0.66's keybinding docs
and tested in real sessions (tmux with a scratch destination):

- **tig** (`user-config/.tigrc`): `Y` = commit under the cursor (status view: working changes), `U` =
  branch/commit vs main. The `+` command flag echoes the written path (or the error) to the status bar.
- **lazygit** (`user-config/lazygit/config.yml`): `Y` in commits (`--commit`), localBranches
  (`--range main...<branch>`) and files (`--working`); `output: popup` shows the path. Commands are quoted in
  YAML because a plain scalar cannot start with a comma.
- The existing tig `D`/`B` (diffnav) bindings had the same all-zero-id bug on "Unstaged/Untracked" rows; fixed
  in the same branch (`git diff HEAD` on those rows). `B` (and lazygit's branch `D`) also fall back from `main`
  to `master` now, like `,mobile-review --range`.
- No dotbot change needed: `~/.tigrc`, the lazygit config and `~/bin/my_scripts` are already linked.

## Implementation steps (all done)

1. Spike diff rendering (diff2html-cli; later superseded by the template-based viewer, see above).
2. `,md-to-html --inline-images`.
3. `,mobile-review` skeleton: option parsing, destination resolution, timestamped naming, `--simulate`,
   temp-name + rename placement (first `.<name>.part`, replaced by Syncthing's own `.syncthing.<name>.tmp` after
   checking what Syncthing actually ignores).
4. `md` and `files` subcommands (`md` later accepts several files and became the implicit mode: `,mobile-review a.md b.pdf c.png`); `,md-to-html --prerender-mermaid` (Mermaid was CDN-only in HTML output).
5. `diff` subcommand: selectors, commit/range/working/stdin, shebang language hints, `--pdf`.
10. Follow-ups: implicit mode + YYMMDDHHMM timestamp; `diff` writes a folder (`00_diff.html` + rendered markdown of the diff at its last commit); `files`
    copies into a folder instead of zipping (zip removed).
6. Dependencies: `npm:diff2html-cli` in `mise.toml` and `,__install_requirements.sh`.
7. Keybindings in tig and lazygit.
8. Docs: `my_scripts/README.md`, `AGENTS.md`, script header comments, this file.
9. Verify: every subcommand tested against a scratch `--dest` and then against the real
   `~/Sync/Mobile/00_review`; first round (md sample, commit diff, zip — the zip was dropped later) opened on the tablet — fine; the
   reworked diff viewer was sent as a second sample.

## Tests

`tests_my_scripts/mobile_review/` (minitest; `tests_my_scripts/run mobile_review`, ~15 s): 16 unit tests that
`load` the script, and ~36 end-to-end tests that run the real CLI in scratch git repos with a scratch `--dest`
(commit, working tree incl. untracked files, ranges, stdin, implicit md/pdf/image mode, `files`, PDF, errors).
Added after a bug found with the tig `Y` binding: tig's `+` flag keeps only the first line of output and then
closes the pipe, so the converters' progress `puts` raised EPIPE after the first markdown file and only one of
several markdown files was rendered. Fix: converter output is captured (`capture_output`), stdout carries just the
written path, and a closed pipe at the end is ignored; protected by
`test_e2e_survives_a_reader_that_closes_stdout_after_the_first_line_like_tig` (verified to fail when the fix is
removed). The suite also pins down: committed-version markdown, link rewriting, untracked files, the
`diff.mnemonicPrefix` header paths, the all-zero tig object id, `main`/`master` fallback, and the Syncthing temp
files being renamed away. Rules for keeping it current are in `tests_my_scripts/README.md` and `AGENTS.md`.

## Open questions / later

- **Retention:** `00_review/` will grow. Possible `,mobile-review --prune DAYS`, or a Syncthing
  staggered-versioning/cleanup rule on the tablet side.
- **Return path:** getting review comments back from the tablet (e.g. a `01_review_notes/` folder or annotated
  PDFs) is out of scope.
- **Large diffs:** consider a size cap (warn above N MB / N files) so a huge range does not produce an unusable page.
- **Optional `--difft` mode** (difftastic, syntax-aware diffs via ANSI→HTML) for refactor-heavy reviews.
