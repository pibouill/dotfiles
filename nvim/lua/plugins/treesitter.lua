-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   treesitter.lua                                     :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/02/02 14:04:58 by pibouill          #+#    #+#             --
--   Updated: 2026/02/02 14:05:02 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		version = false,
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
		end,
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"glsl",
				"lua",
				"make",
				"meson",
				"python",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"rust",
				"json",
				"yaml",
				"bash",
				"toml",
			},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			folds = {
				enable = true,
			},
		},
	},
}
