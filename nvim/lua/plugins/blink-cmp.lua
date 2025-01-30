-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   blink-cmp.lua                                      :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/18 14:04:54 by pibouill          #+#    #+#             --
--   Updated: 2025/01/08 13:17:30 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets', "giuxtaposition/blink-cmp-copilot" },
	version = 'v0.*',
	opts = {
		keymap = { preset = 'default' },
		completion = {
			menu = {},
			ghost_text = { enabled = true },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono',
			kind_icons = {
				Copilot = " ",
				Text = '󰉿',
				Method = '󰊕',
				Function = '󰊕',
				Constructor = '󰒓',

				Field = '󰜢',
				Variable = '󰆦',
				Property = '󰖷',

				Class = '󱡠',
				Interface = '󱡠',
				Struct = '󱡠',
				Module = '󰅩',

				Unit = '󰪚',
				Value = '󰦨',
				Enum = '󰦨',
				EnumMember = '󰦨',

				Keyword = '󰻾',
				Constant = '󰏿',

				Snippet = '󱄽',
				Color = '󰏘',
				File = '󰈔',
				Reference = '󰬲',
				Folder = '󰉋',
				Event = '󱐋',
				Operator = '󰪚',
				TypeParameter = '󰬛',
			},
		},
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
			},
		},
	},
}
