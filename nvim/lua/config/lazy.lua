-- DEFAULT LAZYVIM CONF
--
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
-- 	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
-- 	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
-- 	if vim.v.shell_error ~= 0 then
-- 		vim.api.nvim_echo({
-- 			{ "failed to clone lazy.nvim:\n", "errormsg" },
-- 			{ out, "warningmsg" },
-- 			{ "\npress any key to exit..." },
-- 		}, true, {})
-- 		vim.fn.getchar()
-- 		os.exit(1)
-- 	end
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup({
-- 	spec = {
-- 		-- add lazyvim and import its plugins
-- 		{ "lazyvim/lazyvim", import = "lazyvim.plugins" },
-- 		-- import/override with your plugins
-- 		{ import = "plugins" },
-- 	},
-- 	defaults = {
-- 		-- by default, only lazyvim plugins will be lazy-loaded. your custom plugins will load during startup.
-- 		-- if you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
-- 		lazy = false,
-- 		-- it's recommended to leave version=false for now, since a lot the plugin that support versioning,
-- 		-- have outdated releases, which may break your neovim install.
-- 		version = false, -- always use the latest git commit
-- 		-- version = "*", -- try installing the latest stable version for plugins that support semver
-- 	},
-- 	install = { colorscheme = { "rose-pine", "tokyonight", "habamax" } },
-- 	checker = {
-- 		enabled = true, -- check for plugin updates periodically
-- 		notify = true, -- notify on update
-- 	}, -- automatically check for plugin updates
-- 	performance = {
-- 		rtp = {
-- 			-- disable some rtp plugins
-- 			disabled_plugins = {
-- 				"gzip",
-- 				-- "matchit",
-- 				-- "matchparen",
-- 				-- "netrwplugin",
-- 				"tarplugin",
-- 				"tohtml",
-- 				"tutor",
-- 				"zipplugin",
-- 			},
-- 		},
-- 	},
-- })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "failed to clone lazy.nvim:\n", "errormsg" },
			{ out, "warningmsg" },
			{ "\npress any key to exit..." },
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


-- setup lazy.nvim
require("lazy").setup({
	spec = {

		{ import = "plugins" },
	},

	install = { colorscheme = { "tokyonight", "rose-pine" } },
	checker = { enabled = false, notify = false},
-- 		enabled = true, -- check for plugin updates periodically
-- 		notify = true, -- notify on update
})
