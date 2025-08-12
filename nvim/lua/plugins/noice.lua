-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   noice.lua                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/06 14:17:52 by pibouill          #+#    #+#             --
--   Updated: 2024/12/13 07:39:24 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"folke/noice.nvim",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
				["vim.diagnostic.open_float"] = false,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			command_palette = false,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	-- stylua: ignore
	keys = {
		{ "<leader>sn", "", desc = "+noice"},
		{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
		{ "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
		{ "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
		{ "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
		{ "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
		{ "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
		{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
		-- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
	},
	config = function(_, opts)
		-- HACK: noice shows messages from before it was enabled,
		-- but this is not ideal when Lazy is installing plugins,
		-- so clear the messages in this case.
		if vim.o.filetype == "lazy" then
			vim.cmd([[messages clear]])
		end
		require("noice").setup(opts)
	end,
}
