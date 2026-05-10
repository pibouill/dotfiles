-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   treesitter.lua                                     :::      ::::::::   --
--                                                    ::: :::    ::::::   --
--   By: pibouill <pibouill@student.42prague.com>   ::::+:   :+:+:  :+:+   --
--                                                :+::+:+: :+:+:  :+::+   --
--   Created: 2026/02/02 14:04:58 by pibouill        :+::+:+: :+:+:  :+::+   --
--   Updated: 2026/05/05 14:04:58 by pibouill         ###     ####     ###   --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter").setup({})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					pcall(vim.treesitter.stop)
				end,
			})

			require("nvim-treesitter").install({
				"c",
				"cpp",
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
				"html",
				"css",
				"javascript",
				"typescript",
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}