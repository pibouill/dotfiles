# Neovim

Config lives in `nvim/lua/config/` (options, keymaps, filetypes, lazy bootstrap)
with one file per plugin in `nvim/lua/plugins/`.

## AI Setup

Three complementary plugins:

*   **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** — inline ghost-text completions
    and the Copilot LSP (which also powers NES below). Only attaches for enabled filetypes
    (`c`, `cpp`, `lua`, `python`, ...) — edit `copilot.lua` to change.
*   **[sidekick.nvim](https://github.com/folke/sidekick.nvim)** — Next Edit Suggestions (NES)
    from the Copilot LSP, plus generic AI CLI sessions (Gemini, etc.) in tmux panes.
*   **[claudecode.nvim](https://github.com/coder/claudecode.nvim)** — Claude Code via the
    official IDE websocket protocol: agentic editing with native in-editor diff review.

Keybindings:

| Key | Plugin | Action |
|---|---|---|
| `<A-l>` (insert) | copilot | Accept ghost-text suggestion (`<A-]>`/`<A-[>` cycle, `<C-]>` dismiss) |
| `<Tab>` (normal) | sidekick | Jump to / apply Next Edit Suggestion |
| `<leader>aa` / `<C-.>` | sidekick | Toggle CLI session (Gemini, etc.) |
| `<leader>as` | sidekick | Select an installed CLI tool |
| `<leader>ad` | sidekick | Detach/close the current CLI session |
| `<leader>ap` | sidekick | Select a prompt (Explain, Optimize, ...) |
| `<leader>at` / `<leader>af` / `<leader>av` | sidekick | Send this / file / visual selection as context |
| `<leader>ac` | claudecode | Toggle Claude Code terminal |
| `<leader>ar` | claudecode | Resume a previous Claude session |
| `<leader>ab` | claudecode | Add current buffer (or oil file) as context |
| `<leader>ae` (visual) | claudecode | Send selection to Claude |
| `<leader>ay` / `<leader>an` | claudecode | Accept / deny Claude's proposed diff (`:w` in the diff also accepts) |

Typical flows:

*   **Completion:** type, `<A-l>` to accept ghost text; after an edit, `<Tab>` in normal mode
    jumps to Copilot's suggested next edit, `<Tab>` again applies it (chains through the file).
*   **Agentic:** `<leader>ac` opens Claude Code, `<leader>ab`/`<leader>ae` feed it context,
    proposed edits open as native diffs to accept (`<leader>ay`) or reject (`<leader>an`).

## Keybindings Cheat Sheet

Leader is `<Space>`. `jk` in insert mode is `<Esc>`. (Full definitions in
`nvim/lua/config/keymaps.lua` and each plugin's `keys` spec.)

`<A-…>` bindings work on both OSes: natively on Linux, and on macOS via
`option_as_alt = "OnlyLeft"` in `alacritty_macos.toml` (left Option = Alt,
right Option still types symbols/accents) — see [alacritty.md](alacritty.md).

**Files & navigation**

| Key | Action |
|---|---|
| `<leader>e` | Oil file explorer (floating) |
| `<C-p>` | Telescope git files |
| `<leader>fF` / `<leader>ff` | Telescope find files (git root / buffer dir) |
| `<leader>vg` / `<leader>ps` | Telescope live grep / grep for input |
| `<leader>pn` | Telescope nvim config files |
| `<leader>vh` | Telescope help tags |
| `<leader>h` / `<C-e>` | Harpoon add file / quick menu |
| `<A-1..5>` | Harpoon jump to file (macOS fallback: `¡™£¢∞` for terminals without option-as-alt) |
| `<C-h/j/k/l>` | Move between splits |
| `<C-f>` | tmux-sessionizer in a new tmux window |

**LSP & diagnostics**

| Key | Action |
|---|---|
| `gd` / `gD` / `gr` | Go to definition / declaration / references |
| `K` / `gK` | Hover (hover.nvim) / select hover source |
| `<leader>ca` | Code action (normal & visual) |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format (clang-format) |
| `<leader>xx` / `<leader>xX` | Trouble diagnostics (workspace / buffer) |
| `<leader>cs` / `<leader>cS` | Trouble symbols / LSP references |

**Git**

| Key | Action |
|---|---|
| `<leader>gs` | Fugitive status |
| `<leader>gg` / `<leader>gf` / `<leader>gl` | Lazygit / current file history / log |
| `<leader>gb` / `<leader>gB` | Blame line / open in browser |
| `<leader>gh…` | Gitsigns hunks: `s`tage, `r`eset, `p`review, `d`iff, `b`lame (see `git-signs.lua`) |

**Editing & misc**

| Key | Action |
|---|---|
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `J` / `K` (visual) | Move selected lines down / up |
| `<leader>L` / `<leader>T` | Substitute word under cursor (all / confirm each) |
| `<leader>u` | Undotree |
| `<leader>z` / `<leader>Z` | Zen mode / zoom (snacks) |
| `<leader>.` | Scratch buffer |
| `<leader>q` / `<leader>Q` | Toggle quickfix / loclist (quicker) |
| `<leader>x` | `chmod +x` current file |
| `<leader>H` | Insert/update 42 header |
| `<leader>nn` | NoNeckPain (center buffer) |
| `<leader>u…` | Snacks toggles: `s`pell, `w`rap, `d`iagnostics, inlay `h`ints, ... (see `snacks.lua`) |

## PDF Viewing

`pdfreader.nvim` was dropped: it renders pages via the Kitty graphics protocol,
which Alacritty does not implement (no kitty protocol, no sixel). The
terminal-agnostic replacement (in `nvim/lua/config/filetypes.lua`):

*   Opening a `*.pdf` shows its **extracted text** via `pdftotext -layout`
    (poppler, in the Brewfile) — readonly, searchable, grep-able, works over
    ssh/tmux in any terminal.
*   `<leader>po` in that buffer opens the actual PDF in an external viewer
    (`open` on macOS; `zathura` if installed, else `xdg-open` on Linux).

For real rendering with vim-style keybindings, install one of:

*   [sioyek](https://sioyek.info) — cross-platform (macOS cask + Linux), geared
    toward reading papers/books, vim-ish navigation.
*   [zathura](https://pwmt.org/projects/zathura/) — the classic minimal vim-like
    reader; `apt install zathura` on Ubuntu (macOS needs a homebrew tap).

## DOCX Editing

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
