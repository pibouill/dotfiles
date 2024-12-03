return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<C-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
		  "<A-" .. i .. ">",
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
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
--         vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
--         vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
--         vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
--         vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
--
--         -- Toggle previous & next buffers stored within Harpoon list
-- 		-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- 		-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
--     end,
-- }
