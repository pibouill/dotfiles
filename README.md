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
