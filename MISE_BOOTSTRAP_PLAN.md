# Plan: replace dotbot with `mise bootstrap` (+ cleanup pass)

Status: phase 1 done (uncommitted, 2026-11-14); phases 2–5 to do. Checked against mise 2026.11.8.

Docs: <https://mise.jdx.dev/bootstrap.html>, <https://mise.jdx.dev/dotfiles.html>,
<https://mise.jdx.dev/bootstrap/files.html>, `mise bootstrap --help`.

## Decisions

| Topic | Decision |
|---|---|
| Targets | Linux (primary) **and macOS**: keep the per-OS split. |
| `./install` | Makes the links **and** installs the global mise tools (`--only dotfiles,tools`). |
| `/etc` (`system-config/`) | **Not migrated yet.** Diff the repo files against the live `/etc` first, then decide (phase 4). |
| `~/.gitconfig` | **Stays manual**: a hand-made link to `~/Sync/Private/20_code/secret-configs/gitconfig`, documented only. The stale `user-config/.gitconfig` is deleted. |
| Cleanup | Done **before** the migration, so only live entries are translated. |
| `my_scripts/` | Reviewed too: list candidates, **you confirm**, then delete. |

---

## Why

- One tool instead of two: mise already manages the tools, and dotbot is only
  installed (via `pipx:dotbot`) to make symlinks.
- `mise bootstrap` installs `[tools]` too, so `mise install` + `./install` become one command.
- `--prune-dotfiles` removes links for entries that were deleted, which dotbot cannot do.
- `mise dot status` / `mise bootstrap -n` show the state, and `mise dot add` / `mise dot edit`
  can replace copying back from `~/` by hand.

## What the tests showed (sandboxed `$HOME`)

These behaviours were checked by running mise against a throwaway home directory:

| Behaviour | Result | What it means for the plan |
|---|---|---|
| Symlinks that dotbot already made, pointing at the same source | Treated as "up to date" | Switching over is a no-op on this machine; nothing needs to be unlinked first. |
| A real file already at the target | Refused (`refusing to overwrite existing files (use --force)`) | Same safety as dotbot's default. |
| Missing parent directories | Created automatically | Same as dotbot's `create: true`. |
| `os = "macos"` on a `[dotfiles]` entry | **Silently ignored**: the macOS link was created on Linux | `os` only works on `[bootstrap.files]`, so OS splits need separate files. |
| `mise.linux.toml` / `mise.macos.toml` in the repo | Loaded with `-E linux` (or `MISE_AUTO_ENV=1`) | This handles the per-OS split. |
| `[dotfiles]` inside `mise.toml` | Relative sources resolve from `~/.config/mise/`, because that file is symlinked there as the global config | Run from another directory, this fails ("sources do not exist"). So **`[dotfiles]` must not go in `mise.toml`**. |
| Links for entries removed from the config | `--prune-dotfiles` only removes links that mise itself deployed | The links dotbot made for deleted entries must be removed by hand (phase 1). |
| `[bootstrap.files]` for `/etc` | **Copies only, no symlinks**; uses `sudo` only when a change needs it | Relevant for phase 4. |
| `/etc` on this machine | Real files that differ from the repo; `install.conf.system.yaml` was never applied | Applying would overwrite the live `/etc/fstab` and apt sources. |
| Hooks (`[bootstrap.hooks]`) | Run on every bootstrap, shown (not run) in `-n` | Fine for the Gnome `gsettings` script, which is idempotent. |

---

## Phase 1: cleanup of deprecated configs (one commit) — DONE

Delete from the repo, remove the matching entry from `install.conf.shared.yaml`,
**and remove the live symlink in `~`**, because mise won't prune links it didn't make:

| Repo path | Live link to remove | Why it's deprecated |
|---|---|---|
| `user-config/.ackrc` | `~/.ackrc` | `ack` is not installed; last change 2016 |
| `user-config/bin/prompt.sh` | `~/bin/prompt.sh` | last change 2013; not sourced by `.zshrc` or `.bashrc` |
| `user-config/config/ranger/` | `~/.config/ranger` | last change 2019 |
| `user-config/.ideavimrc` | `~/.ideavimrc` | no longer used (confirmed) |
| `user-config/.gitconfig` | none (`~/.gitconfig` points to `~/Sync/...`) | unused copy; it already differs from the live config |
| `user-config/.zsh_plugins.txt` | `~/.zsh_plugins.txt` | only listed spaceship-prompt; its loader was commented out |
| `other.rst` | none | 2019 list of Firefox extensions and Gnome themes |

Also:

- `.gitignore`: drop the stale `/user-config/.vim/bundle/vundle` line.
- `user-config/.zshrc`:
  - Remove the dead code: commented pyenv/nvm/asdf/virtualenv blocks, the commented
    theme alternatives, and `# source ~/.zsh_plugins.sh`.
  - Remove the unused `SPACESHIP_*` prompt block and the `# ZSH_THEME="spaceship"` line;
    `miloshadzic` stays the theme. Also update the AGENTS.md "Prompt" line.
  - Change `FZF_DEFAULT_COMMAND` from `ag` (not installed) to
    `rg --files --hidden --glob '!.git'` (`rg` works on Linux and macOS).
  - Consolidate the scattered `PATH` edits.
  - Check `.zsh_plugins.txt`: its loader line is commented out, so it may be dead too.
- Check: open a new zsh and confirm the prompt, `fzf` (Ctrl-T), `atuin`, `zoxide` and `mise` all work.

## Phase 2: review `my_scripts/` (one commit, after you confirm)

1. List each script with its last commit date, whether it runs on this machine
   (are its dependencies installed?) and whether anything references it.
   Candidates already spotted: `sync_me`, `xinput-toggle`, `,tplink-status`,
   `net-speed`, `,scan-unpaper`, `,resize-tmpfs`.
2. You mark each one keep or delete; nothing is deleted without that.
3. Remove the deleted scripts from `my_scripts/README.md` and `AGENTS.md`.
   Scripts with a test suite (`,mobile-review`, `,clean-filename`) are not candidates.

## Phase 3: migrate the links to `mise bootstrap` (one commit)

### Layout

```
mise.toml            # unchanged role: global tools, symlinked as ~/.config/mise/config.toml
                     #   remove pipx + "pipx:dotbot"
mise.dotfiles.toml   # [dotfiles] shared links
mise.linux.toml      # [dotfiles] ~/.config/lazygit/config.yml
                     # [bootstrap.hooks] post-dotfiles = gsettings/dconf/flameshot script
mise.macos.toml      # [dotfiles] "~/Library/Application Support/lazygit/config.yml"
install              # thin wrapper
```

The `mise.<env>.toml` files are environment files. They are loaded only from
inside the repo with `-E`, never as global config, so relative sources work.

### `mise.dotfiles.toml` (after the phase 1 deletions)

```toml
[dotfiles]
# ── Shells & environment
"~/.bashrc"          = { source = "user-config/.bashrc" }
"~/.zshenv"          = { source = "user-config/.zshenv" }
"~/.zshrc"           = { source = "user-config/.zshrc" }
# ── Editors / languages
"~/.gemrc"           = { source = "user-config/.gemrc" }
"~/.config/nvim"     = { source = "user-config/config/nvim" }        # whole-dir symlink
# ── Terminal / git / multiplexer
"~/.config/ghostty"  = { source = "user-config/ghostty" }
"~/.tigrc"           = { source = "user-config/.tigrc" }
"~/.tmux.conf"       = { source = "user-config/.tmux.conf" }
# ── AI / CLI tools
"~/.config/opencode.jsonc"        = { source = "user-config/opencode.jsonc" }
"~/.config/crush.json"            = { source = "user-config/crush.json" }
"~/.claude/statusline-command.sh" = { source = "user-config/claude/statusline-command.sh" }
"~/.config/mise/config.toml"      = { source = "mise.toml" }
# ── Scripts on PATH
"~/bin/my_scripts" = { source = "my_scripts" }
```

### `mise.linux.toml`

```toml
[dotfiles]
"~/.config/lazygit/config.yml" = { source = "user-config/lazygit/config.yml" }

[bootstrap.hooks]
post-dotfiles = '''
# Gnome workspaces/keybindings + Flameshot: the two shell blocks from install.conf.linux.yaml, verbatim
'''
```

### `install`

```bash
#!/usr/bin/env bash
# Apply the dotfiles with mise bootstrap. Usage: ./install [-n] [mise bootstrap flags]
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
case "$(uname -s)" in
  Linux)  OS=linux ;;
  Darwin) OS=macos ;;
  *) echo "Unknown OS: $(uname -s)" >&2; exit 1 ;;
esac
exec mise -C "$DIR" -E "dotfiles,$OS" bootstrap --only dotfiles,tools "$@"
```

`./install -n` (dry run) still works because `-n` is also `mise bootstrap --dry-run`.
On a new machine: install mise, `git clone`, `mise trust`, then `./install`.
The `./install system` mode is removed until phase 4.

### Steps

1. Run `mise trust` on the repo.
2. Write the three files from the YAML that survived phase 1.
3. Run `./install -n`, then `mise -C . -E dotfiles,linux dot status`; every entry
   should be "up to date" because the dotbot links match.
4. Run `./install` and confirm nothing changed except the hook re-running.
5. Delete `install.conf.shared.yaml`, `install.conf.linux.yaml` and
   `install.conf.darwin.yaml`, and remove `pipx` / `pipx:dotbot` from `mise.toml`.
   Then remove the leftover installs with `mise uninstall pipx:dotbot pipx`.
6. Keep `install.conf.system.yaml` until phase 4, or move its notes into phase 4
   and delete it (decide in phase 4).
7. macOS check (next time on the Mac): run `./install -n`; the only OS-specific
   entry there is lazygit.

## Phase 4: `/etc` review (separate, later)

1. Diff each file against the live system:
   `diff system-config/etc/fstab /etc/fstab`, and the same for
   `apt/sources.list`, `apt/sources.list.d/intellinuxgraphics.list` and
   `sysctl.d/98-dirty.conf`. Note that `sources.list.d/` live has brave, cloudflare and
   jellyfin, and the repo has only intel graphics.
2. Then decide:
   - **(a)** refresh the repo from the live files and manage them via `mise.system.toml` /
     `[bootstrap.files]` (copies, `os = "linux"`, owner root, mode `0644`, applied
     with `mise -E system bootstrap --only files`); or
   - **(b)** delete `system-config/` and `install.conf.system.yaml`.

## Phase 5: docs audit (same commit as phase 3, or right after)

- `AGENTS.md`: update
  - the Quick Start;
  - the repository structure (remove deleted files, add `mise.*.toml`);
  - replace the "Dotbot" section with a "mise bootstrap" section (layout, `-E`, why
    `[dotfiles]` isn't in `mise.toml`, removed entries need manual unlinking);
  - the setup flow;
  - the gotchas (drop fixed and obsolete ones, such as `~/.git_template`, if they no longer apply).
- `README.md`: setup instructions.
- `MOBILE_REVIEW_PLAN.md`: its dotbot mention.
- `IMPROVEMENTS.md`: re-audit and drop the obsolete items (for example `setup_new_machine.sh`
  and `_setup_debian.sh`, which don't exist), or delete the file if little is left.
- `my_scripts/README.md`: match phase 2.
- Mark this plan as done, or delete it once everything is applied.

## Trade-offs

- **Experimental:** bootstrap is still under `experimental = true` (already on in
  `mise.toml`), and its syntax may still change.
- **Hooks repeat:** the Gnome hook runs on every `./install`; harmless because it is idempotent.
- **Unused features:** leave out dotfile history/sync (`track`, `origin`,
  `history-watch`) and `[bootstrap.settings]`; git and the hook already cover them.

## Open questions

None. `.ideavimrc` is deleted and the spaceship block is removed (both confirmed 2026-11-14).
