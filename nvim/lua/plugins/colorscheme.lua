return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
		lazy = false,
		priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "auto", -- auto, main, moon, or dawn
                dark_variant = "main", -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    migrations = true, -- Handle deprecated options automatically
                },

                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                },
            })
			vim.cmd.colorscheme("rose-pine")
        end,
    },
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	name = "gruvbox",
	-- 	config = function ()
	-- 		require("gruvbox").setup({
	-- 			  terminal_colors = true, -- add neovim terminal colors
	-- 			  undercurl = true,
	-- 			  underline = true,
	-- 			  bold = true,
	-- 			  italic = {
	-- 				strings = true,
	-- 				emphasis = true,
	-- 				comments = true,
	-- 				operators = false,
	-- 				folds = true,
	-- 			  },
	-- 			  strikethrough = true,
	-- 			  invert_selection = false,
	-- 			  invert_signs = false,
	-- 			  invert_tabline = false,
	-- 			  invert_intend_guides = false,
	-- 			  inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 			  contrast = "hard", -- can be "hard", "soft" or empty string
	-- 			  palette_overrides = {},
	-- 			  overrides = {},
	-- 			  dim_inactive = false,
	-- 			  transparent_mode = true,
	-- 		})
	-- 	end,
	-- },
}
