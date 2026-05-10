# My Dotfiles

This repository contains my personal dotfiles for various applications and shell environments.

## Installation

The `install.sh` script is used to set up a new system. It installs Homebrew and then uses the `Brewfile` to install all the necessary packages.

To install, run the following command:

```bash
./install.sh
```

The script will create a log file in the `logs` directory.

## Shell

The `.zshrc` file is configured for both macOS and Linux. It includes:

*   Dynamic Homebrew setup.
*   Organized `PATH` management.
*   Useful aliases and functions.
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
