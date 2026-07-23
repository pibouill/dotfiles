-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   harpoon.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/18 12:35:36 by pibouill          #+#    #+#             --
--   Updated: 2024/12/18 12:39:44 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function ()
		local harpoon = require("harpoon")
		harpoon:setup({
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			}
		})
	end,
	keys = function()
		local harpoon = require("harpoon")
		local keys = {
			{
				"<leader>h",
				function()
					harpoon:list():add()
				end,
				desc = "Harpoon File",
			},
			{
				"<C-e>",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
		}

		-- <A-1..5> works on Linux natively and on macOS via
		-- option_as_alt = "OnlyLeft" in alacritty_macos.toml
		for i = 1, 5 do
			table.insert(keys, {
				"<A-" .. i .. ">",
				function()
					harpoon:list():select(i)
				end,
				desc = "Harpoon to File " .. i,
			})
		end

		-- macOS fallback for terminals without option-as-alt
		-- (Option+1..5 types these symbols on a US layout)
		if (vim.uv or vim.loop).os_uname().sysname == "Darwin" then
			local syms = { "¡", "™", "£", "¢", "∞" }
			for i, sym in ipairs(syms) do
				table.insert(keys, {
					sym,
					function()
						harpoon:list():select(i)
					end,
					desc = "Harpoon to File " .. i,
				})
			end
		end
		return keys
	end,
}
