local	options = {
	ensure_installed = {
		"rust",
		"toml",
		"yaml",
		"c",
		"cpp",
		"printf",
		"make",
		"cmake",
		"javascript",
		"python",
		"Dockerfile",
		"markdown",
		"lua",
		"vim",
		"vimdoc",
		"markdown_inline",
		"bash",
		"go",
		"diff",
		"help",
		"tmux",
	},
	highlight = { enable = true, additional_vim_regex_highlighting = false, },
	indent = { enable = true },
	sync_install = false,
}
return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	auto_install = true,

	build = ":TSUpdate",
	opts = function()
		return require("plugins.treesitter")
	end,
	config =
		function(_, opts)
	


		require("nvim-treesitter.configs").setup(opts)
	end,
}
