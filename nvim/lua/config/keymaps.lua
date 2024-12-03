-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   keymaps.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+       --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/02 10:30:50 by pibouill          #+#    #+#             --
--   Updated: 2024/12/02 10:30:50 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- sets
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = "on"
vim.opt.mouse = "r" -- Enable mouse click + copy paste
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.incsearch = true
vim.opt.history = 200
vim.opt.compatible = false
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.laststatus = 2 -- For lightline
vim.opt.showmode = false -- lightline handles this
vim.opt.spell = false -- Disable spelling check
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumheight = 10
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Highlight SignColumn
vim.cmd("highlight! link SignColumn Normal")

-- Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
    end,
})

-- Keymaps
-- local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local dmap = vim.keymap.del

-- System clipboard
map("n", "<Leader>y", '"+y', opts)
map("v", "<Leader>y", '"+y', opts)
map("n", "<Leader>Y", '"+Y', opts)

-- Navigation enhancements
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Split navigation mappings in Lua
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to the left split" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to the lower split" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to the upper split" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to the right split" })

-- -- File explorer
-- map("n", "<Leader>pv", ":Ex<CR>", opts)

-- Moving lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Joining lines
map("n", "J", "mzJ`z", opts)

-- Change all occurrences
map("n", "<Leader>L", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
map("n", "<Leader>T", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]], opts)

-- Reload init.lua
-- map("n", "<Leader><Leader>", ":so $MYNVIMRC<CR>", opts)

-- Splits
map("n", "<Leader>vs", ":vs<CR>", opts)
map("n", "<Leader>sp", ":sp<CR>", opts)

-- No-op mappings
map("n", "<c-z>", "<nop>", opts)
map("n", "Q", "<nop>", opts)
map("n", ":W", "<nop>", opts)


-- Buffer resizing
map("", "<A-S-Left>", "<C-W>>", {})
map("", "<A-S-Right>", "<C-W><", {})
map("", "<A-S-Up>", "<C-W>+", {})
map("", "<A-S-Down>", "<C-W>-", {})

-- Cursor styling
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Python recommended style
vim.g.python_recommended_style = 0

-- Plugin-specific mappings
map("n", "<Leader>x", ":!chmod +x %<CR>", opts)

-- tmux seeshionizer
if vim.fn.mapcheck("<C-f>", "n") ~= "" then
  vim.keymap.del("n", "<C-f>")
end

map("n", "<C-f>", function()
  vim.cmd("silent !tmux neww tmux-sessionizer")
  vim.cmd("redraw!")
end, opts)

-- Map <Esc> in insert mode
map("i", "jk", "<Esc>", opts)

-- Disable f1 for 42 header's sake
map('n', '<F1>', '<nop>', { desc = "Disable F1" })
map('i', '<F1>', '<nop>', { desc = "Disable F1 in Insert mode" })
map('v', '<F1>', '<nop>', { desc = "Disable F1 in Visual mode" })
map('t', '<F1>', '<nop>', { desc = "Disable F1 in Terminal mode" })

--Unamp Ctrls+numbers for harpoon
map('n', '<C-1>', '<nop>', { desc = "Disable F1" })
map('n', '<C-2>', '<nop>', { desc = "Disable F1 in Insert mode" })
map('n', '<C-3>', '<nop>', { desc = "Disable F1 in Visual mode" })
map('n', '<C-4>', '<nop>', { desc = "Disable F1 in Terminal mode" })

map("n", "<F1>", ":FtHeader<CR>")
