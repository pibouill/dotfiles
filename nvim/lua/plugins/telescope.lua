local builtin = require('telescope.builtin')
local map = vim.keymap.set
map('n', '<C-p>', builtin.git_files, { desc = 'git files search' })
map('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
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
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
		  end,
		},
	  },
	  {
		"nvim-telescope/telescope-symbols.nvim",
	  },




	-- requires = { {'nvim-lua/plenary.nvim'} }
}
