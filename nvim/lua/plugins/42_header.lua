-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   42_header.lua                                      :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/06 09:44:14 by pibouill          #+#    #+#             --
--   Updated: 2026/02/20 14:44:12 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"Diogo-ss/42-header.nvim",
	cmd = { "Stdheader" },
	keys = {
		{ "<leader>H", "<cmd>Stdheader<cr>", desc = "Insert/Update 42 Header" }
	},
	event = { "BufRead", "BufNewFile" },

	opts = {
		default_map = false, -- Default mapping <F1> in normal mode.
		auto_update = false, -- Update header when saving.
		user = "pibouill",
		mail = "pibouill@student.42prague.com",
		git = {
			enabled = true,
			bin = "git",
		}
	},

	-- config = function(_, opts)
	-- 	require("42header").setup(opts)
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		callback = function()
	-- 			if vim.bo.modified then
	-- 				vim.cmd("Stdheader")
	-- 			end
	-- 		end,
	-- 	})
	-- end,
}
