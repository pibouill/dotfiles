-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   lualine.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/15 15:11:08 by pibouill          #+#    #+#             --
--   Updated: 2024/12/15 15:11:35 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },

	config = function ()
		-- Eviline config for lualine
		-- Author: shadmansaleh
		-- Credit: glepnir
		local lualine = require('lualine')

		-- Color table for highlights
		-- stylua: ignore
		--
		local colors = {
			bg       = '#191724',
			fg       = '#e0def4',
			yellow   = '#f6c177',
			cyan     = '#9ccfd8',
			darkblue = '#26233a',
			green    = '#31748f',
			orange   = '#fe8019',
			violet   = '#c4a7e7',
			magenta  = '#cba7e7',
			blue     = '#9ccfd8',
			red      = '#eb6f92',
		}
		--
		-- gruvbox
		-- local colors = {
		-- 	bg       = '#282828',
		-- 	fg       = '#ddc7a1',
		-- 	yellow   = '#d8a657',
		-- 	cyan     = '#89b482',
		-- 	darkblue = '#0e363e',
		-- 	green    = '#a9b665',
		-- 	orange   = '#e78a4e',
		-- 	violet   = '#d3869b',
		-- 	magenta  = '#d3869b', -- Same as violet
		-- 	blue     = '#7daea3',
		-- 	red      = '#ea6962',
		-- }


		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand('%:p:h')
				local gitdir = vim.fn.finddir('.git', filepath .. ';')
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = '',
				section_separators = '',
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left {
			function()
				return '▊'
			end,
			color = { fg = colors.cyan }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		}

		ins_left {
			function()
				return ''  -- You can add a mode indicator if desired
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					['r?'] = colors.cyan,
					['!'] = colors.red,
					t = colors.red,
				}
				-- Get current mode and fallback to red if mode is unknown
				local current_mode = vim.fn.mode()
				return { fg = mode_color[current_mode] or colors.red }
			end,
			padding = { right = 1 },
		}

		ins_left {
			-- filesize component
			'filesize',
			cond = conditions.buffer_not_empty,
		}

		ins_left {
			'filename',
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = 'bold' },
			path = 3,
		}

		ins_left { 'location' }

		ins_left {
			function()
				return tostring(vim.fn.line('$'))
			end,
			color = { fg = colors.fg, gui = 'bold' }
		}

		ins_left {
			'diagnostics',
			sources = { 'nvim_diagnostic' },
			symbols = { error = ' ', warn = ' ', info = ' ' },
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.cyan },
			},
		}

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins_left {
			function()
				return '%='
			end,
		}

		ins_left {
			function()
				local msg = 'No Active Lsp'
				local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					-- Check if filetypes is defined and matches the current buffer's filetype
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = ' LSP:',
			color = { fg = '#928374', gui = 'bold' },
		}

		-- Add components to right sections
		ins_right {
			'o:encoding', -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = 'bold' },
		}

		ins_right {
			'fileformat',
			fmt = string.upper,
			icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
			color = { fg = colors.green, gui = 'bold' },
		}

		ins_right {
			'branch',
			icon = '',
			color = { fg = colors.violet, gui = 'bold' },
		}

		ins_right {
			'diff',
			-- Is it me or the symbol for modified us really weird
			symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		}

		ins_right {
			function()
				return '▊'
			end,
			color = { fg = colors.cyan},
			padding = { left = 1 },
		}

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end
}
