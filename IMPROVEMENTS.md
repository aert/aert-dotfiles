# Dotfiles Improvements

Areas for improvement identified in this dotfiles repository.

## High Priority

### 1. Hardcoded Paths

`grox.rb` uses a non-portable shebang:
```ruby
#!/home/ari/.asdf/shims/ruby
```

**Fix:** Use `/usr/bin/env ruby` instead for portability across machines and usernames.

### 2. Hardcoded Configuration Values

- `my_tplink_status.py:11` - Hardcoded IP `HOST = "192.168.0.1"`
- `grox.rb:11-14` - Hardcoded device names (eDP-1, ATML1000, Synaptics touchpad)

**Fix:** Externalize to environment variables or config files.

### 3. Typos in setup_new_machine.sh

- Line 29: `packgekit-offline-update.service` should be `packagekit-offline-update.service`
- Line 49: Double `sudo` (`sudo sudo systemctl`)

### 4. Missing Error Handling

Most shell scripts lack error handling. Only 3 scripts use `set -ex`:
- `my_git_clean_local_branches.sh`
- `my_git_files_recent.sh`
- `_setup_debian.sh`

**Fix:** Add `set -e` (exit on error) to all shell scripts. Consider `set -u` (error on undefined variables) as well.

## Medium Priority

### 5. Outdated Remnants

- `nvim.old/` directory exists but appears to be old config - should be archived or removed
- Many commented-out sections in `.zshrc` for pyenv/nvm/asdf
- Multiple commented-out virtualenv configurations

### 6. Script Portability

`net-speed.sh` uses Linux-specific paths:
```bash
/sys/class/net/
```

This breaks on macOS despite the repo claiming multi-OS support.

**Fix:** Add OS detection and platform-specific implementations.

### 7. Missing Dependency Documentation

- Ruby scripts require `activesupport` gem but no `Gemfile` exists
- Python scripts have no `requirements.txt`
- Shell scripts may fail silently if tools aren't installed (yt-dlp, tig, fd-find, etc.)

**Fix:** Create dependency manifests for each language.

### 8. POSIX Compatibility Issue in prompt.sh

Line 100 uses bash-specific `[[ ]]` syntax but shebang is `#!/bin/sh`:
```sh
if [[ -n "$ZSH_VERSION" ]]; then
```

**Fix:** Use POSIX-compatible `[ ]` or change shebang to `#!/bin/bash`.

## Low Priority

### 9. Minimal Documentation

README.md only mentions Gnome Terminal settings. Missing:
- Repository structure overview
- Setup instructions for new machines
- Tool dependencies list
- Which OS versions are supported

### 10. Git Template Directory Missing

`.gitconfig` references `~/.git_template` which doesn't exist in the repo:
```ini
templatedir = ~/.git_template
```

### 11. Inconsistent File Permissions

`my_encode_720p.rb` isn't executable but should be (other Ruby scripts are).

### 12. No Backup Mechanism

Makefile symlinks configs without backing up existing files first. Could overwrite user's existing configurations.

**Fix:** Add backup step before creating symlinks.

### 13. Empty Files

- `user-config/.elinks/bookmarks` is empty
- Some `.gitkeep` placeholders for empty directories

### 14. Path Organization in .zshrc

PATH modifications are scattered throughout the file rather than consolidated in one section.

## Summary

| Priority | Count | Examples |
|----------|-------|----------|
| High | 4 | Hardcoded paths, typos, error handling |
| Medium | 4 | Outdated code, portability, dependencies |
| Low | 6 | Documentation, permissions, backups |
