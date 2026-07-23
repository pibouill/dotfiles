# tmux

`tmux/.tmux.conf`, symlinked to `~/.tmux.conf` by `install.sh`.

Prefix is **`C-Space`**. Windows/panes are numbered from 1 and renumbered on
close; new windows and splits open in the current pane's directory. Copy mode
uses vi keys. Status bar is Rosé Pine (gruvbox variant commented out).

## Keybindings

| Key | Action |
|---|---|
| `<prefix> h/j/k/l` | Navigate panes (vim motions) |
| `<prefix> %` / `<prefix> "` | Split horizontal / vertical (same pwd) |
| `<prefix> c` | New window (same pwd) |
| `<prefix> i` | cht.sh lookup in a new window (`tmux_cht`) |
| `<prefix> r` | Reload `.tmux.conf` |
| `<prefix> I` | Install plugins (tpm) |
| `<prefix> C-s` | Save session (tmux-resurrect) |

## Neovim interop

*   `escape-time 10` + `xterm-keys on` — `<A-…>` mappings pass through to nvim.
*   `focus-events on` and `tmux-256color` with RGB — per nvim `:checkhealth`.
*   sidekick.nvim uses tmux as its CLI mux backend; `<C-f>` in nvim opens
    tmux-sessionizer in a new window.
