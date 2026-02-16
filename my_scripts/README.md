# My Scripts

Collection of custom utility scripts for various tasks.

## Markdown & Document Conversion

### `,md-to-html` - Markdown to HTML Converter
Convert GitLab-flavored Markdown to HTML with Mermaid diagram support.

**Features:**
- GitLab-flavored Markdown (tables, task lists, code blocks)
- Mermaid diagrams rendered as inline SVG images (copyable to Word)
- YAML frontmatter stripping
- Standalone HTML with embedded CSS
- Fragment mode for embedding

**Quick Usage:**
```bash
# Basic conversion
,md-to-html document.md

# Custom output directory
,md-to-html -o ~/html *.md

# Fragment mode (no HTML wrapper)
,md-to-html --fragment document.md
```

**Options:**
- `-o, --output-dir DIR` - Output directory (default: same as input)
- `-f, --[no-]fragment` - Output HTML fragment instead of standalone document
- `-s, --simulate` - Simulate only (no HTML generation)
- `-h, --help` - Show help

---

## File Management

### `my_clean_filename.rb` - Filename Cleaner & Organizer
Cleans filenames, removes useless files, and organizes directories.

**Features:**
- Sanitizes filenames (removes special characters, normalizes spaces)
- Removes useless files (.DS_Store, Thumbs.db, etc.)
- Flattens single-file directories
- Removes empty directories
- Simulation mode (dry-run) by default

**Quick Usage:**
```bash
# Simulate cleanup (preview changes)
my_clean_filename.rb ~/Downloads

# Execute cleanup
my_clean_filename.rb --force ~/Downloads

# Run specific processors only
my_clean_filename.rb --only=cleaner,useless ~/Downloads
```

**Options:**
- `-f, --force` - Execute changes (default is simulation mode)
- `--only=PROCESSORS` - Run only specific processors (cleaner, useless, onefile, empty)
- `-h, --help` - Show help

---

### `my_rm_youtube_id.rb` - YouTube ID Remover
Removes YouTube video IDs from filenames in bulk.

**Quick Usage:**
```bash
# Simulate (preview changes)
my_rm_youtube_id.rb ~/Videos

# Execute changes
my_rm_youtube_id.rb -f ~/Videos
```

Converts: `Video Title [dQw4w9WgXcQ].mp4` → `Video Title.mp4`

---

### `my_flatten_pdf_dir.py` - PDF Directory Flattener
Flattens nested PDF directories into a single level.

**Quick Usage:**
```bash
python3 my_flatten_pdf_dir.py ~/Documents/PDFs ~/Documents/PDFs_Flat
```

---

## Media Processing

### `my_encode_720p.rb` - Video Encoder
Encodes videos to 720p using ffmpeg.

**Quick Usage:**
```bash
my_encode_720p.rb input.mp4
# Creates: input-720p.mp4
```

---

### `my_scan_unpaper.rb` - Scan Cleaner
Cleans scanned documents using unpaper.

**Quick Usage:**
```bash
my_scan_unpaper.rb scan.jpg
# Creates: scan-cleaned.jpg
```

---

## System Utilities

### `my_cypher.rb` - ROT13 Cipher
Simple ROT13 encoder/decoder.

**Quick Usage:**
```bash
# From argument
my_cypher.rb "Hello World"

# From stdin
echo "Hello World" | my_cypher.rb
```

---

### `my_docker_df.rb` - Docker Disk Usage
Shows Docker disk usage statistics.

**Quick Usage:**
```bash
my_docker_df.rb
```

---

### `my_ec` - Emacs Client
Opens files in existing Emacs instance or starts new one.

**Quick Usage:**
```bash
my_ec file.txt
```

---

### `grox.rb` - Grox Utility
Custom utility script for grox operations.

**Quick Usage:**
```bash
grox.rb [options]
```

---

## i3 Window Manager Scripts

### `i3-exit` - i3 Exit Menu
Provides exit options for i3 window manager.

### `i3-keyboard-layout` - i3 Keyboard Layout Switcher
Switches keyboard layouts in i3.

### `my_i3_status.sh` - i3 Status Bar
Custom status bar for i3.

---

## Git Utilities

### `my_git_clean_local_branches.sh` - Git Branch Cleaner
Removes merged local branches.

**Quick Usage:**
```bash
my_git_clean_local_branches.sh
```

---

### `my_git_files_recent.sh` - Recent Git Files
Lists recently modified files in git repository.

**Quick Usage:**
```bash
my_git_files_recent.sh
```

---

## Network & System

### `my_toggle_wifi.sh` - WiFi Toggle
Toggles WiFi on/off.

**Quick Usage:**
```bash
my_toggle_wifi.sh
```

---

### `my_tplink_status.py` - TP-Link Status
Checks TP-Link router status.

**Quick Usage:**
```bash
python3 my_tplink_status.py
```

---

### `my_resize_tmpfs.sh` - tmpfs Resizer
Resizes tmpfs filesystems.

**Quick Usage:**
```bash
my_resize_tmpfs.sh <size>
```

---

### `my_fix_screen.sh` - Screen Fixer
Fixes screen resolution/display issues.

**Quick Usage:**
```bash
my_fix_screen.sh
```

---

### `my_emacs_stop.sh` - Emacs Daemon Stop
Stops Emacs daemon.

**Quick Usage:**
```bash
my_emacs_stop.sh
```

---

## Installation

Most scripts are standalone and require only their dependencies:

- **Ruby scripts**: Require Ruby 2.7+ (use `bundler/inline` for gem dependencies)
- **Python scripts**: Require Python 3.6+
- **Shell scripts**: Require bash

Make scripts executable:
```bash
chmod +x script_name
```

## Conventions

- Scripts starting with `,` are actively used utilities
- Scripts with `my_` prefix are personal utility scripts
- All scripts use simulation/dry-run mode by default where applicable (use `-f` or `--force` to execute)

## Contributing

These are personal scripts. Feel free to copy and modify for your own use.
