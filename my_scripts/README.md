# My Scripts

Collection of utility scripts on `$PATH` via `~/bin/my_scripts/`.

## Convention

All scripts use a `,` prefix for easy discovery (sorts to top in listings),
dash-separated names, no file extensions. Shebang lines determine the interpreter.

## Markdown & Document Conversion

### `,md-to-html`
GitLab-flavored Markdown to HTML with Mermaid diagram support (inline SVG).

```bash
,md-to-html document.md
,md-to-html -o ~/html *.md
,md-to-html --fragment document.md
```

### `,md-preview`
Renders markdown to HTML and opens in browser. Saved to `/tmp/md-previews/`.

```bash
,md-preview document.md
```

### `,md-to-pdf`
Markdown to PDF conversion.

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