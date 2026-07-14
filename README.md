# My Dotfiles

This repository contains my personal dotfiles, kept in sync across two environments:

*   A personal macOS laptop.
*   A 42 school Ubuntu machine (detected via hostname, see `is_42prague` in `install.sh`/`.zshrc`).

Both `install.sh` and `.zshrc` branch on OS and hostname to pick the right Homebrew location,
PATH entries, and certificate settings for whichever machine is running them.

## Installation

The `install.sh` script is used to set up a new system. It installs Homebrew (in a
school-appropriate location under `goinfre`/`sgoinfre` on 42 machines, or the standard
location elsewhere), then uses the `Brewfile` to install all the necessary packages, and
symlinks the rest of this repo's configs into place.

To install, run the following command:

```bash
./install.sh          # add --dry-run / -n to preview actions without making changes
```

The script will create a log file in the `logs` directory (gitignored, kept local to each machine).

`new_install.sh` and `scripts/42brew_install.sh` have been removed — they were superseded
by the unified, environment-aware logic now in `install.sh`.

## Shell

The `.zshrc` file is configured for both macOS and Linux. It includes:

*   Dynamic Homebrew setup, cached per machine.
*   Organized `PATH` management, with 42-specific entries (`NVM_DIR`, `CARGO_HOME`, etc.) under `sgoinfre`.
*   Useful aliases and functions — notably `dfl` (jump to this repo), `weather` (wraps `bin/weather.sh`),
    and `swcaps` (Linux-only Caps/Ctrl swap via `scripts/gnome_tweaks_caps_ctrl.sh`).
*   fzf integration.
*   Starship prompt.

## Neovim

### PDF Editing

Uses [pdfreader.nvim](https://github.com/r-pletnev/pdfreader.nvim) to view PDFs directly in Neovim via Kitty's graphics protocol.

Requirements:
- Kitty or Ghostty terminal
- ImageMagick
- Ghostscript
- poppler-utils

Keybindings:
- `<leader>pd` - Show recent PDF books
- `<leader>pm` - Show PDF bookmarks
- `n` / `p` - Next/previous page
- `z` / `q` - Zoom in/out

### DOCX Editing

DOCX files are ZIP archives containing XML. Use pandoc to convert:

```bash
# Convert DOCX to markdown, edit in nvim, then convert back
pandoc document.docx -t markdown -o document.md
nvim document.md
pandoc document.md -o document.docx
```

Or use the quick alias (if defined in shell):
```bash
doc2md document.docx   # Convert to markdown
md2doc document.md     # Convert back to DOCX
```
