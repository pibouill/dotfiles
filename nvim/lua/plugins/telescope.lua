-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   telescope.lua                                      :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/06 13:11:26 by pibouill          #+#    #+#             --
--   Updated: 2024/12/06 13:12:34 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"nvim-telescope/telescope.nvim", tag = '0.1.8',
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "git files search" },
			{ "<leader>ps", function()
				require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
			end, desc = "search with grep" },
		},
		require('telescope').setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_width = 0.5,
						-- preview_cutoff = 20,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--glob", "!**/.git/*", "-L" },
					hidden = true,
					-- theme = 
				}
			},
			extensions = {
				fzf = {}
			},
		}),
		config = function ()
			-- telescope to nvim config
			vim.keymap.set("n", "<leader>pn", function ()
				require("telescope.builtin").find_files {
					cwd = vim.fn.stdpath("config")
				}
			end)
		end,

	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		"nvim-telescope/telescope-fzf-native.nvim", build = 'make',
	},
	{
		  "nvim-telescope/telescope.nvim",
		  optional = true,
	},
}
