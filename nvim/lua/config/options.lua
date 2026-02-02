-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   options.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/08 11:24:19 by pibouill          #+#    #+#             --
--   Updated: 2024/12/08 11:25:52 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- sets
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.modeline = false -- Disabled for security
vim.opt.modelines = 5
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- But not if the search pattern contains uppercase letters
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.history = 200
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300 -- A higher value for better performance
vim.opt.colorcolumn = "80"
vim.opt.wildmode = "longest:full,full" -- Corrected syntax for wildmode
vim.opt.spell = false -- Disable spelling check
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumheight = 10
vim.opt.termguicolors = true
--obsidian
vim.opt.conceallevel = 1
vim.opt.timeoutlen = 300

-- Keymap to clear search highlights
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })

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
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
		-- vim.opt_local.indentexpr=""
    end,
})

vim.filetype.add({
	extension = {
		tpp = "cpp",
	}
})

vim.keymap.set('n', '<leader>cf', ':%!clang-format<CR>', { noremap = true, silent = true, desc = "Format whole file with clang-format" })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.h",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
    end,
})

-- Cursor styling
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp

vim.opt.swapfile = false
vim.g.rocks_hererocks = false
