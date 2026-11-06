# My Scripts

Collection of utility scripts on `$PATH` via `~/bin/my_scripts/`.

## Convention

All scripts use a `,` prefix for easy discovery (sorts to top in listings),
dash-separated names, no file extensions. Shebang lines determine the interpreter.

## Markdown & Document Conversion

### `,md-to-html`
GitLab-flavored Markdown to HTML with Mermaid and PlantUML diagram support. PlantUML is always
pre-rendered to inline SVG; Mermaid is rendered in the browser from a CDN script by default.

| Flag | Effect |
|---|---|
| `-o, --output-dir DIR` | output directory (default: next to the input) |
| `-p, --output PATH` | exact output path (single input only) |
| `-f, --fragment` | HTML fragment instead of a standalone document |
| `-i, --inline-images` | embed local images as base64 `data:` URIs (self-contained HTML that can travel) |
| `-m, --prerender-mermaid` | pre-render Mermaid to inline SVG via `mmdc`; no CDN script, works offline |
| `-s, --simulate` | dry run |

```bash
,md-to-html document.md
,md-to-html -o ~/html *.md
,md-to-html --fragment document.md
,md-to-html -i -m -p /tmp/out.html document.md   # fully self-contained, offline-safe
```

Without `-i`, relative image paths are rewritten to absolute filesystem paths (fine locally,
broken once the file is copied elsewhere).

### `,md-preview`
Renders markdown to HTML and opens in browser. Saved to `/tmp/md-previews/`.

```bash
,md-preview document.md
```

### `,md-to-pdf`
Markdown to PDF conversion (mermaid and PlantUML diagrams pre-rendered to SVG). Options: `-o/--output-dir`,
`-p/--page-size` (default A4), `-m/--margin MM`, `-s/--simulate`. It shares the Mermaid pre-rendering code
with `,md-to-html -m` (the base class owns `render_mermaid_to_svg`).

### `,mobile-review`
Prepares something for review on the tablet and drops it into the Syncthing folder
`~/Sync/Mobile/00_review` (override with `--dest` or `$MOBILE_REVIEW_DIR`; that folder is never created for
you). Everything is prefixed with a `YYMMDDHHMM` timestamp (`2611061219_notes.html` = 2026-11-06 12:19; `-2`
is appended if the same name is sent twice in one minute).

```bash
,mobile-review notes.md other.md       # .md -> self-contained HTML each (images base64, mermaid pre-rendered)
,mobile-review report.pdf shot.png     # .pdf / images -> plain copies, only the timestamp prefix added
,mobile-review --pdf notes.md          # markdown -> PDF instead
,mobile-review md notes.md             # explicit form of the first line (still works)
,mobile-review files src/ notes.txt    # folder with the files as is, no conversion (.git/ skipped)
,mobile-review diff --commit HEAD      # FOLDER: 00_diff.html + rendered markdown files of the diff (--pdf: PDFs)
,mobile-review diff --range main...feature   # everything a branch adds vs main
,mobile-review diff --working          # git diff HEAD
git diff ... | ,mobile-review diff -   # any unified diff from stdin
,mobile-review -n ...                  # dry run: show what would be written
```

Options: `-n/--simulate`, `--name NAME` (single input only), `--pdf`, `--dest DIR`, and for `diff` the selectors
`--commit REV`, `--range A...B`, `--working`.

**Implicit mode.** With no subcommand the type of *each argument is guessed from its extension*:
`.md`/`.markdown` is converted, `.pdf` and images (png, jpg, jpeg, gif, webp, svg, bmp, avif, heic, heif) are
copied unchanged. One output file per input, types can be mixed. Anything else (other extensions, folders) is
an error that points to `files PATH...`.

**`diff` produces a folder** (`<ts>_<repo>_<sha>/`), not a single file:

- `00_diff.html` (or `00_diff.pdf`): the diff page;
- one `<name>.html` (or `.pdf`) for every markdown file added, modified or renamed in the diff (deleted ones
  are skipped), rendered with the same options as `md` and **as of the diff's last commit**: the commit, the
  range tip, or the working tree for `--working`. Local images and `<!-- include: -->` files are read from
  that commit too, so the rendering matches the diff even if the working tree has moved on. Two files with
  the same basename become `<dir>__<name>`. A markdown file that fails to render is skipped with a warning.
  `diff -` (stdin) has no repo to read from, so it yields the diff page only.
- **Links between those markdown files keep working**: `[x](other.md#a)` (relative, `../`, or GitLab-style
  `/root/relative`) is rewritten to the rendered sibling `other.html#a` when `other.md` is in the same folder;
  links to files that are not in the folder are left as they are. In the diff page every such markdown file has a
  **Rendered ↗** button in its header that opens the sibling.
- **`--working` includes untracked files** (shown as new files; `.gitignore` is respected, files over 1 MB are
  skipped and counted in the page header). Untracked markdown files are rendered too.

`files PATH...` produces a folder too: the files copied as they are (paths kept relative to their common
parent, `.git/` skipped, symlinks stored as regular files).

**The diff page** is a single self-contained HTML file (no network needed) with a sticky toolbar:
**Unified / Split** (Split is the default on wide screens, i.e. landscape), **Wrap** on/off, **A− / A+** text
size; the choices are remembered in the browser. Code is syntax-highlighted (GitHub light/dark theme, follows
the OS setting; extensionless scripts are detected from their shebang) and set in an embedded Iosevka subset
(`lib/mobile-review/fonts/`, SIL OFL). `--pdf` prints it unified and wrapped on A4.

**Syncthing safety.** Syncthing does not ignore `.part`/hidden names, but it does skip its own
`.syncthing.<name>.tmp` files, so every output file is written under that name and renamed when complete: a
half-written file is never synced. Folders are created at once and filled file by file (`00_diff.*` last), so
the tablet may briefly see a partly filled folder, never a partial file.

**Keybindings.** tig: `Y` (commit under the cursor; working changes in the status view) and `U` (branch/commit
vs main). lazygit: `Y` in the commits, branches and files views. Two conveniences: tig's all-zero id on its
"Unstaged/Untracked changes" rows means `--working`, and `main...X` falls back to `master...X` when there is no
`main`. tig's `B` and lazygit's branch `D` (diffnav) use the same fallback.

**Tests:** `tests_my_scripts/run mobile_review` (unit + end-to-end, ~15 s); run it after any change to this script and
update it with every behaviour change (rules in `tests_my_scripts/README.md`). `,clean-filename` has its own harness,
`,clean-filename-tester`.

**Needs:** `diff2html-cli` (installed through global mise by `,__install_requirements.sh` if missing; used as the
source of diff2html's bundles) and chromium/google-chrome for `--pdf`.

### Setup

`mise` is the only prerequisite. Run `,__install_requirements.sh` to install
everything `,md-to-html`, `,md-to-pdf` and `,mobile-review` need (ruby, node, the `commonmarker` gem,
`@mermaid-js/mermaid-cli`, PlantUML, `diff2html-cli`). It is idempotent, only installs what is missing (global ruby/node are
never upgraded; PlantUML and mermaid-cli are upgraded to latest; diff2html-cli is only installed if missing), and works on Linux and macOS (Apple Silicon).

## Global mise tools

### `,mise-global-exec`
Runs a command on the **global** mise toolset, ignoring the current directory's `mise.toml`
(so a project pinned to e.g. ruby 2.7 doesn't affect it). Also usable as a script shebang:
`#!/usr/bin/env -S ,mise-global-exec ruby` (or `node`, `python`, ...). `,md-to-html`,
`,md-to-pdf` and `,mobile-review` use it.

```bash
,mise-global-exec node -v
```

## Git Utilities

### `,git-changed`
Lists files changed relative to a base branch (committed + staged + unstaged).
Two-letter status code prefix, color-coded output.

```bash
,git-changed main
,git-changed develop
```

### `,git-clean-local-branches`
Removes merged local branches.

### `,git-files-recent`
Lists recently modified files in git repository.

## File Management

### `,clean-filename`
Sanitizes filenames, removes junk files, flattens single-file directories,
removes empty dirs. Simulation mode by default.

```bash
,clean-filename ~/Downloads          # simulate
,clean-filename -f ~/Downloads       # execute
,clean-filename --only=cleaner -f .  # rename only
```

### `,clean-filename-tester`
Integration test harness for `,clean-filename`.

### `,flatten-pdf-dir`
Flattens nested PDF directories into a single level.

```bash
,flatten-pdf-dir ~/Documents/PDFs ~/Documents/PDFs_Flat
```

## Media Processing

### `,encode-720p`
Encodes videos to 720p using ffmpeg.

```bash
,encode-720p input.mp4
# Creates: input-720p.mp4
```

### `,scan-unpaper`
Cleans scanned documents using unpaper.

```bash
,scan-unpaper scan.jpg
# Creates: scan-cleaned.jpg
```

### `,yd-music`, `,yd-podcast`, `,yd-vid`
YouTube download wrappers (yt-dlp).

## System Utilities

### `,docker-df`
Docker disk usage statistics.

### `,resize-tmpfs`
Resizes tmpfs filesystems.

```bash
,resize-tmpfs <size>
```

### `,tplink-status`
Checks TP-Link router status.

### `net-speed`
Network speed readout (Linux `/sys/class/net/`).

### `sync_me`
Sync utility.

### `xinput-toggle`
Toggles XInput device settings.

## Dependencies

- **Ruby scripts**: Ruby 2.7+ (use `bundler/inline` for gem dependencies)
- **Python scripts**: Python 3.6+
- **Shell scripts**: bash
- **External tools**: ffmpeg, yt-dlp, unpaper, FontForge, Docker