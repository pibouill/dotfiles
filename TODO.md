## System Configuration Migration

- [ ] Investigate using `stow` for managing symlinks to simplify the installation script.
- [ ] Finalize `dconf` backup and restore process for GNOME settings.
  - `dconf dump / > dconf.txt`
  - `dconf load / < dconf.txt`

## Installation Script Improvements

- [ ] Refine `install.sh` to be more modular and easier to debug.
- [ ] Add checks for all dependencies before starting the installation.

## Application Configurations

- [ ] Configure `dircolors` using the Dracula theme.
- [ ] Solve potential `curl` issues when installed with Brew.
