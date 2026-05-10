-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   pdf.nvim                                            :::      ::::::::   --
--                                                    +:+,+        ++:    ++:    --
--   By: pibouill <pibouill@student.42prague.com>   +# ++#+#++    ++:++    +:++   --
--                                                +#        +#++#+        ++#   --
--   Created: 2025/05/05 12:00:00 by pibouill          #+#        #+#        ++#   --
--   Updated: 2025/05/05 12:00:00 by pibouill         ###        ###          ##   --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"r-pletnev/pdfreader.nvim",
		lazy = true,
		ft = "pdf",
		cmd = "PDFReader",
		dependencies = {
			"folke/snacks.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>pd", "<cmd>PDFReader showRecentBooks<cr>", desc = "PDF recent books" },
			{ "<leader>pm", "<cmd>PDFReader showBookmarks<cr>", desc = "PDF bookmarks" },
		},
		config = function()
			require("pdfreader").setup({})
		end,
		init = function()
			vim.api.nvim_create_autocmd("BufReadPost", {
				pattern = "*.pdf",
				callback = function()
					pcall(function()
						require("snacks.indent").disable()
					end)
				end,
			})
		end,
	},
}