aert-dotfiles
=============

My config files and scripts. Linux first (Pop!_OS / Debian / Ubuntu on Gnome), plus macOS.

| Directory | What | Where it ends up |
|---|---|---|
| `user-config/` | per-user dotfiles (zsh, nvim, tmux, ghostty, tig, lazygit, ...) | symlinked into `~/` |
| `my_scripts/` | shared executable scripts (all `,`-prefixed so they sort first) | on `$PATH` via `~/bin/my_scripts` |
| `tests_my_scripts/` | automated tests for the scripts (minitest; `tests_my_scripts/run`) | — |
| `system-config/` | system-level configs (fstab, apt sources, sysctl) | `/etc/` (needs sudo) |

Everything is linked with [dotbot](https://github.com/anishathalye/dotbot); `install` picks the right
config files for the OS (`install.conf.shared.yaml` + `install.conf.linux.yaml` or `.darwin.yaml`).

## Setup on a new machine

```bash
mise install              # installs dotbot (via pipx) — mise is the only prerequisite
./install                 # link all dotfiles (idempotent; existing plain files are left alone)
./install -n              # dry run: show what would change
sudo ./install system     # link the /etc/ configs
```

Gnome extensions and theme: see `other.rst`.

The global mise config (`~/.config/mise/config.toml`) is this repo's `mise.toml` (symlinked by `./install`):
ruby, node, python, lazygit, PlantUML, `diff2html-cli`, ... Scripts that need those run on it through
`,mise-global-exec`, so a project-local `mise.toml` never leaks in.

## Scripts worth knowing

Full list with usage: [`my_scripts/README.md`](my_scripts/README.md).

- **Markdown**: `,md-to-html` (GitLab-flavoured markdown, Mermaid/PlantUML, self-contained output),
  `,md-to-pdf`, `,md-preview`. Their dependencies are installed by `,__install_requirements.sh`.
- **Git**: `,git-changed`, `,git-clean-local-branches`, `,git-files-recent`.
- **`,mobile-review`**: send things to the Android tablet for review (below).

## Code review on the tablet (`,mobile-review`)

One command puts review material into the Syncthing folder `~/Sync/Mobile/00_review`, which syncs to the
tablet. Files are prefixed with a `YYMMDDHHMM` timestamp (`2611061219_notes.html` = 2026-11-06 12:19).

```bash
,mobile-review notes.md other.md      # markdown -> self-contained HTML (images inlined, Mermaid pre-rendered)
,mobile-review report.pdf shot.png    # PDFs and images -> copied as they are
,mobile-review diff --commit HEAD     # folder: 00_diff.html + the markdown files of the diff, as of that commit
,mobile-review diff --range main...my-branch
,mobile-review files src/ notes.txt   # folder with files copied as they are
```

`--working` includes untracked files, and links between the rendered markdown files keep working (each markdown
file in the diff page has a "Rendered ↗" button).

The diff page works offline and has a toolbar for Unified/Split, Wrap and text size, GitHub-style syntax
highlighting (light/dark) and an embedded Iosevka font. Keybindings: in **tig** `Y` sends the commit under the
cursor (or the working changes in the status view) and `U` the branch vs main; in **lazygit** `Y` does the same
in the commits, branches and files views. Details: [`my_scripts/README.md`](my_scripts/README.md); design and
decisions: [`MOBILE_REVIEW_PLAN.md`](MOBILE_REVIEW_PLAN.md).

## Tests

```bash
tests_my_scripts/run                 # all suites, ~15 s
tests_my_scripts/run mobile_review   # one script
```

Run the suite of any script you change, add a regression test with every bug fix, and update the tests with
every behaviour change. Details and layout: [`tests_my_scripts/README.md`](tests_my_scripts/README.md).

## More documentation

- [`AGENTS.md`](AGENTS.md): orientation for AI agents and contributors (layout, conventions, gotchas).
- [`my_scripts/README.md`](my_scripts/README.md): every script with examples.
- [`tests_my_scripts/README.md`](tests_my_scripts/README.md): how the tests are organised and the rules for changing them.
- [`IMPROVEMENTS.md`](IMPROVEMENTS.md): known issues and TODOs.

## Terminal settings

**Gnome Terminal**

- background: `#3C4C55`
- font: `Iosevka Term Slab Medium 11`
