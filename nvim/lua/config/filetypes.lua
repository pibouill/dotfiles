-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   filetypes.lua                                     :::      ::::::::   --
--                                                    +:+ :+    :+:+:     ++: --
--   By: pibouill <pibouill@student.42prague.com>   ++:+ :+:+:++:+:+:  +:++   --
--                                                ++: ++:+:+++:   +:++    ++: --
--   Created: 2025/05/05 by pibouill                                 ++:    ++: --
--   Updated: 2025/05/05 by pibouill                                 ++:    ++: --
--                                                                            --
-- ************************************************************************** --

-- Disable treesitter features for non-text buffers
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local bad_filetypes = { "pdf", "zip", "tar", "gz", "bz2", "rar", "7z", "netrw", "dirvish", "fzf" }
		for _, ft in ipairs(bad_filetypes) do
			if args.match == ft then
				vim.b[0].treesitter = false
				pcall(function()
					require("treesitter-context").disable()
				end)
				return
			end
		end
	end,
})

-- Also try to catch on BufReadPost
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local ext = vim.fn.fnamemodify(args.file, ":e")
		local bad_exts = { "pdf", "zip", "tar", "gz", "bz2", "rar", "7z", "png", "jpg", "jpeg", "gif", "ico", "webp" }
		for _, e in ipairs(bad_exts) do
			if ext == e then
				vim.b[0].treesitter = false
				pcall(function()
					require("treesitter-context").disable()
				end)
				return
			end
		end
	end,
})