-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   copilot.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/20 09:57:26 by pibouill          #+#    #+#             --
--   Updated: 2025/01/20 09:58:16 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function ()
			require('copilot').setup({
				panel = {
					enabled = false,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>"
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4
					},
				},
				suggestion = {
					enabled = false,
					-- enabled = not vim.g.ai_cmp,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<A-l>",
						accept_word = false,
						accept_line = false,
						next = "<A-]>",
						prev = "<A-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = true,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
					-- disabled bc 
					c = false,
					lua = true,
					python = true,
				},
				copilot_node_command = 'node', -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})

		end,
	},
	{
		"giuxtaposition/blink-cmp-copilot",
	}
}
