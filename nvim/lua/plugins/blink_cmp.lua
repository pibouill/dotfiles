-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   blink_cmp.lua                                      :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/01/30 15:28:50 by pibouill          #+#    #+#             --
--   Updated: 2026/01/30 15:30:47 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"saghen/blink.cmp",
	-- build = "cargo +nightly build --release",
	version = "1.*",
	dependencies = { 'rafamadriz/friendly-snippets' },
	opts = {
		signature = {
			enabled = true,
			trigger = {
				enabled = true,
				show_on_keyword = true,
				show_on_insert = true,
			},
		},
		fuzzy = { implementation = 'prefer_rust_with_warning' },

	},
	window = {
		border = "rounded",
		treesitter_highlighting = true,
		show_documentation = true,
	},
	config = function(_, opts)
		require("blink.cmp").setup(opts)

		vim.keymap.set("i", "<C-x>", function()
			require("blink.cmp").show()
		end, { noremap = true, silent = true })
	end,
}
