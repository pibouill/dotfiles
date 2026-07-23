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

-- PDFs: show extracted text via pdftotext (poppler) — works in any terminal,
-- no graphics protocol needed (Alacritty has none)
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.pdf",
	callback = function(args)
		local buf = args.buf
		if vim.fn.executable("pdftotext") == 0 then
			vim.notify("pdftotext not found (install poppler)", vim.log.levels.WARN)
			return
		end
		local out = vim.fn.systemlist({ "pdftotext", "-layout", args.file, "-" })
		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
		vim.bo[buf].modifiable = false
		vim.bo[buf].readonly = true
		vim.bo[buf].buftype = "nowrite"
		vim.bo[buf].filetype = "text"
		-- open the real PDF in an external viewer
		vim.keymap.set("n", "<leader>po", function()
			local opener = vim.fn.has("mac") == 1 and "open"
				or (vim.fn.executable("zathura") == 1 and "zathura" or "xdg-open")
			vim.system({ opener, args.file }, { detach = true })
		end, { buffer = buf, desc = "Open PDF in external viewer" })
	end,
})