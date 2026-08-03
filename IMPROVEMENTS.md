# Dotfiles Improvements

Areas for improvement identified in this dotfiles repository.

## High Priority

### 1. Hardcoded Configuration Values

- `,tplink-status:11` - Hardcoded IP `HOST = "192.168.0.1"`

**Fix:** Externalize to environment variables or config files.

### 2. Typos in setup_new_machine.sh

- Line 29: `packgekit-offline-update.service` should be `packagekit-offline-update.service`
- Line 49: Double `sudo` (`sudo sudo systemctl`)

### 3. Missing Error Handling

Most shell scripts lack error handling. Only 3 scripts use `set -ex`:
- `,git-clean-local-branches`
- `,git-files-recent`
- `_setup_debian.sh`

**Fix:** Add `set -e` (exit on error) to all shell scripts. Consider `set -u` (error on undefined variables) as well.

## Medium Priority

### 4. Outdated Remnants

- `nvim.old/` directory exists but appears to be old config - should be archived or removed
- Many commented-out sections in `.zshrc` for pyenv/nvm/asdf
- Multiple commented-out virtualenv configurations

### 5. Script Portability

`net-speed` uses Linux-specific paths:
```bash
/sys/class/net/
```

This breaks on macOS despite the repo claiming multi-OS support.

**Fix:** Add OS detection and platform-specific implementations.

### 6. Missing Dependency Documentation

- Ruby scripts require `activesupport` gem but no `Gemfile` exists
- Python scripts have no `requirements.txt`
- Shell scripts may fail silently if tools aren't installed (yt-dlp, tig, fd-find, etc.)

**Fix:** Create dependency manifests for each language.

### 7. POSIX Compatibility Issue in prompt.sh

Line 100 uses bash-specific `[[ ]]` syntax but shebang is `#!/bin/sh`:
```sh
if [[ -n "$ZSH_VERSION" ]]; then
```

**Fix:** Use POSIX-compatible `[ ]` or change shebang to `#!/bin/bash`.

## Low Priority

### 8. Minimal Documentation

README.md only mentions Gnome Terminal settings. Missing:
- Repository structure overview
- Setup instructions for new machines
- Tool dependencies list
- Which OS versions are supported

### 9. Git Template Directory Missing

`.gitconfig` references `~/.git_template` which doesn't exist in the repo:
```ini
templatedir = ~/.git_template
```

### 10. No Backup Mechanism

Makefile symlinks configs without backing up existing files first. Could overwrite user's existing configurations.

**Fix:** Add backup step before creating symlinks.

### 11. Empty Files

- `user-config/.elinks/bookmarks` is empty
- Some `.gitkeep` placeholders for empty directories

### 12. Path Organization in .zshrc

PATH modifications are scattered throughout the file rather than consolidated in one section.

## Summary

| Priority | Count | Examples |
|----------|-------|----------|
| High | 3 | Hardcoded config, typos, error handling |
| Medium | 4 | Outdated code, portability, dependencies |
| Low | 5 | Documentation, permissions, backups |
