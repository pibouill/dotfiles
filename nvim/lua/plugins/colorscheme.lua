-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   colorscheme.lua                                    :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/09 09:32:13 by pibouill          #+#    #+#             --
--   Updated: 2025/01/09 09:33:00 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	-- {
	-- "rose-pine/neovim",
	-- name = "rose-pine",
	-- config = function()
	-- 	vim.cmd("colorscheme rose-pine")
	-- end
	-- },
	--
	--
	--
	--
-- {
--   "catppuccin/nvim",
--   lazy = true,
--   enabled = false,
--   name = "catppuccin",
--   opts = {
--     integrations = {
--       aerial = true,
--       alpha = true,
--       cmp = true,
--       dashboard = true,
--       flash = true,
--       grug_far = true,
--       gitsigns = true,
--       headlines = true,
--       illuminate = true,
--       indent_blankline = { enabled = true },
--       leap = true,
--       lsp_trouble = true,
--       mason = true,
--       markdown = true,
--       mini = true,
--       native_lsp = {
--         enabled = true,
--         underlines = {
--           errors = { "undercurl" },
--           hints = { "undercurl" },
--           warnings = { "undercurl" },
--           information = { "undercurl" },
--         },
--       },
--       navic = { enabled = true, custom_bg = "lualine" },
--       neotest = true,
--       neotree = true,
--       noice = true,
--       notify = true,
--       semantic_tokens = true,
--       snacks = true,
--       telescope = true,
--       treesitter = true,
--       treesitter_context = true,
--       which_key = true,
-- 	  blink_cmp = true,
--     },
--   },
--   },
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = 'medium'
			vim.g.gruvbox_material_better_performance = 0
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_transparent_background = 2
			vim.g.gruvbox_material_ui_contrast = 'high'
		end
	},
}
