# Shell (zsh)

`.zshrc` is configured for both macOS and Linux:

*   Dynamic Homebrew setup, cached per machine (`brew_refresh_cache` to rebuild).
*   Organized `PATH` management, with 42-specific entries (`NVM_DIR`, `CARGO_HOME`, etc.) under `sgoinfre`.
*   fzf integration and Starship prompt.
*   dircolors cache (`dircolors_refresh_cache` to rebuild).

## Notable aliases & functions

**Navigation**

| Alias | Action |
|---|---|
| `dfl` | Jump to this dotfiles repo |
| `work` / `learn` / `libft` | Jump to `~/work/...` |
| `proj` | Jump to `$PROJ` |
| `config` | Jump to `~/.config/` |
| `sgoinfre` | Jump to `/sgoinfre/pibouill` (42 machines) |

**Editors & tools**

| Alias | Action |
|---|---|
| `v` / `vv` | nvim / vim |
| `cat` | bat |
| `p` | python3 |
| `svenv` | `source .venv/bin/activate` |
| `weather` | wraps `bin/weather.sh` |
| `swcaps` | Linux-only Caps/Ctrl swap (`scripts/gnome_tweaks_caps_ctrl.sh`) |

**Git**

| Alias | Action |
|---|---|
| `lg` | lazygit |
| `gl` / `gla` | Pretty graph log (current / all branches) |
| `gol` | `git log --graph --oneline --decorate` |
| `gd` / `gch` / `gsw` / `gwt` / `gru` | diff / checkout / switch / worktree / remote update |

**C / 42 workflow**

| Alias | Action |
|---|---|
| `mr` | `make re` |
| `cwww` | `c++ -Wall -Werror -Wextra -std=c++98` |
| `vglc` / `vglcs` | valgrind leak-check (full / + all leak kinds) |
| `drd` / `helgrind` / `massif` | other valgrind tools |
