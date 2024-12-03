return {
	{
		"nvim-telescope/telescope.nvim", tag = '0.1.8',
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "git files search" },
			{ "<leader>ps", function()
				require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
			end, desc = "search with grep" },
		},
		opts = {
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--glob", "!**/.git/*", "-L" },
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		"nvim-telescope/telescope-fzf-native.nvim", build = 'make',
	},
}
