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

## Documentation

Per-tool docs, keybindings, and workflows live in [`docs/`](docs/):

*   **[Neovim](docs/nvim.md)** — AI setup (copilot / sidekick / claudecode),
    full keybindings cheat sheet, PDF-as-text and DOCX workflows.
*   **[Shell](docs/shell.md)** — zsh setup, aliases, and functions.
*   **[tmux](docs/tmux.md)** — prefix, keybindings, plugins, nvim interop.
*   **[Alacritty](docs/alacritty.md)** — per-OS configs, macOS Option-as-Alt,
    graphics protocol limitations.
