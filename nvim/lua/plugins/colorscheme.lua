return {
	{ 
		"rose-pine/neovim", 
		name = "rose-pine",
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
					transparency = false,
			},
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
}

