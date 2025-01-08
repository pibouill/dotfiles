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
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
	  sync_on_ui_close = true,
    },
  },
  keys = function()
	local harpoon = require("harpoon")
    local keys = {
      {
        "<leader>h",
        function()
          require("harpoon"):list():add()
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
	local is_macos = vim.loop.os_uname().sysname == "Darwin"

		if is_macos then
		  -- OSX-specific mappings
		  vim.keymap.set("n", "¡", function() harpoon:list():select(1) end)
		  vim.keymap.set("n", "™", function() harpoon:list():select(2) end)
		  vim.keymap.set("n", "£", function() harpoon:list():select(3) end)
		  vim.keymap.set("n", "¢", function() harpoon:list():select(4) end)
		else
		  -- Non-OSX mappings
		  for i = 1, 5 do
			table.insert(keys, {
			  "<A-" .. i .. ">",
			  function()
				require("harpoon"):list():select(i)
			  end,
			  desc = "Harpoon to File " .. i,
			})
		  end
		  -- Apply mappings
		  for _, key in ipairs(keys) do
			vim.keymap.set("n", key[1], key[2], { desc = key[3] })
		  end
		end

    return keys
  end,
}
-- return {
--     "ThePrimeagen/harpoon",
--     branch = "harpoon2",
--     dependencies = {
--         "nvim-lua/plenary.nvim"
--     },
--     config = function()
--         local harpoon = require("harpoon")
--         harpoon:setup({
--             settings = {
--                 save_on_toggle = true,
--                 sync_on_ui_close = true,
--             },
--         })
--         vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
--         vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
--         vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
--         vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
--         vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
--         vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
--
--         -- Toggle previous & next buffers stored within Harpoon list
-- 		-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- 		-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
--     end,
-- }
