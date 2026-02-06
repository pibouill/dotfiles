-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   yanky.lua                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/02/06 08:48:01 by pibouill          #+#    #+#             --
--   Updated: 2026/02/06 08:48:06 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return
	{
		"gbprod/yanky.nvim",
		-- default opts
		opts = {
			ring = {
				history_length = 100,
				storage = "shada",
				storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
				sync_with_numbered_registers = true,
				cancel_event = "update",
				ignore_registers = { "_" },
				update_register_on_cycle = false,
				permanent_wrapper = nil,
			},
			picker = {
				select = {
					action = nil, -- nil to use default put action
				},
				telescope = {
					use_default_mappings = true, -- if default mappings should be used
					mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
				},
			},
			system_clipboard = {
				sync_with_ring = true,
				clipboard_register = nil,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 150,
			},
			preserve_cursor_position = {
				enabled = true,
			},
			textobj = {
				enabled = true,
			},
		},
	}
