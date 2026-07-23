# Alacritty

Per-OS configs in `alacritty/`:

*   `alacritty.toml` — Ubuntu (linked by `install.sh` as the default)
*   `alacritty_macos.toml` — macOS (symlink `~/.config/alacritty/alacritty.toml` to this on Macs)
*   `alacritty_ubuntu.toml` / `alacritty_base.toml` — variants
*   Dracula themes are cloned into `~/.config/alacritty/themes` by `install.sh`

Both set JetBrains Mono, 0.9 opacity, no decorations, truecolor.

## macOS: Option as Alt

`alacritty_macos.toml` sets:

```toml
[window]
option_as_alt = "OnlyLeft"
```

Without it, Option+key types symbols (`¡™£¢`, `¬`, ...) and none of nvim's
`<A-…>` bindings (harpoon slots, copilot accept) ever reach nvim. With
`OnlyLeft`, the left Option key is a real Alt while the right one still types
symbols/accents. Alacritty live-reloads config changes.

## No graphics protocol

Alacritty implements neither the Kitty graphics protocol nor sixel — terminal
image/PDF viewers (pdfreader.nvim, termpdf, etc.) cannot work in it. PDFs in
nvim are handled as extracted text instead — see [nvim.md](nvim.md#pdf-viewing).
