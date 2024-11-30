function Color_my_pencils(color)
	-- color = color or "rose-pine"
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function	LineNumberColors()
	vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ffd', bold=false })
	vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold=false })
	vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold=false })
end

Color_my_pencils()
LineNumberColors()
