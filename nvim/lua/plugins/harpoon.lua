-- For later hehe
-- vim.keymap.set('n', '<C-2>', '<nop>')
-- vim.keymap.set('n', '<C-1>', '<nop>')
-- vim.keymap.set('n', '<C-3>', '<nop>')
-- vim.keymap.set('n', '<C-4>', '<nop>')
--

return {
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>a", function() require("harpoon.mark").list():add() end, desc = "Add file to Harpoon" },
            { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
            { "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "Navigate to Harpoon file 1" },
            { "<C-t>", function() require("harpoon.ui").nav_file(2) end, desc = "Navigate to Harpoon file 2" },
            { "<C-n>", function() require("harpoon.ui").nav_file(3) end, desc = "Navigate to Harpoon file 3" },
            { "<C-s>", function() require("harpoon.ui").nav_file(4) end, desc = "Navigate to Harpoon file 4" },
            { "<C-S-P>", function() require("harpoon.ui").nav_prev() end, desc = "Navigate to previous Harpoon file" },
            { "<C-S-N>", function() require("harpoon.ui").nav_next() end, desc = "Navigate to next Harpoon file" },
        },
        config = function()
            require("harpoon").setup({})

            -- Telescope integration (optional)
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            vim.keymap.set("n", "<C-e>", function()
                toggle_telescope(require("harpoon").list())
            end, { desc = "Open Harpoon window (Telescope)" })
        end,
    },
}
