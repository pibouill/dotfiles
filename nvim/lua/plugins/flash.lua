-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   flash.lua                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/03 12:43:37 by pibouill          #+#    #+#             --
--   Updated: 2024/12/03 12:43:37 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

--  Flash enhances the built-in search functionality by showing labels at
--  the end of each match, letting you quickly jump to a specific location.

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	vscode = true,
	---@type Flash.Config
	opts = {
	},
	-- stylua: ignore
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
	config = function(_, opts)
		require("flash").setup(opts)

		-- Override highlight groups
		vim.api.nvim_set_hl(0, "FlashBackdrop", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#d8a657", bg = "#282828", bold = true })
		vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#a9b665", bg = "#282828", underline = true })
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#7daea3", bg = "#282828", bold = true, italic = true })
	end,
}
