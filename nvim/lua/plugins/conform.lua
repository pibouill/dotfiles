-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   conform.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/03 12:59:33 by pibouill          #+#    #+#             --
--   Updated: 2024/12/03 12:59:33 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"stevearc/conform.nvim",
	-- dependencies = { "mason.nvim" },
	lazy = true,
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cF",
			function()
				local pos = vim.api.nvim_win_get_cursor(0)
				require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				vim.api.nvim_win_set_cursor(0, pos)
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
	},
}
