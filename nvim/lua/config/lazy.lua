-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   lazy.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+       --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/03 11:46:38 by pibouill          #+#    #+#             --
--   Updated: 2024/12/03 11:46:38 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "Warningmsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- this is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')

-- setup lazy.nvim
require("lazy").setup({
	spec = {

		{ import = "plugins" },
	},

	install = { colorscheme = { "tokyonight" } },
	-- 		enabled = true, -- check for plugin updates periodically
	-- 		notify = true, -- notify on update
	checker = { enabled = false, notify = false},
	-- disable the popup message when config changes
	change_detection = { enabled = false },
})
