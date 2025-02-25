-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   obsidian.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/02/19 09:18:19 by pibouill          #+#    #+#             --
--   Updated: 2025/02/19 09:20:22 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local vault_path
		if vim.loop.os_uname().sysname == "Darwin" then
			vault_path = "/Users/pierre/Documents/obsidian_vaults/new_obs_vault/obs_vault"
		else
			vault_path = "/home/pibouill/Documents/obs_vault"
		end
		require("obsidian").setup({
			workspaces = {
				{
					name = "obs_vault_42",
					path = vault_path,
				},
			},

		})
	end,
	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true, mode = "n" },
			-- default = true
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true, mode = "n"},
			-- default = true
		},
		-- Smart action depending on context, either follow link or toggle checkbox.
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true, mode = "n" },
			-- default = true
		},
	},
}
