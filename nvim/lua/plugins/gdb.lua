-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   gdb.lua                                            :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/02/06 08:04:47 by pibouill          #+#    #+#             --
--   Updated: 2025/02/06 08:18:39 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"sakhnik/nvim-gdb",
	lazy = true,
	cmd = {
		"GdbStart",
		"GdbStartLLDB",
		"GdbStartPDB",
		"GdbStartBashDB",
	},
	config = function()
		-- Basic configuration
		vim.g.nvimgdb_disable_start_keymaps = 1
		vim.g.nvimgdb_use_find_executables = 0
		vim.g.nvimgdb_use_cmake_to_find_executables = 0

		-- Key mappings
		vim.api.nvim_set_keymap('n', '<leader>dd', ':GdbStart gdb -q ./a.out<CR>', { noremap = true, silent = true })

		vim.api.nvim_set_keymap('n', '<leader>dl', ':GdbStartLLDB lldb ./a.out<CR>', { noremap = true, silent = true })

		vim.api.nvim_set_keymap('n', '<leader>dp', ':GdbStartPDB python -m pdb main.py<CR>', { noremap = true, silent = true })

		-- Custom commands
		vim.api.nvim_create_user_command('GdbBreakpoint', function()
			require('nvimgdb').ToggleBreakpoint()
		end, {})

		vim.api.nvim_create_user_command('GdbContinue', function()
			require('nvimgdb').Continue()
		end, {})

		-- Additional configuration options can be added here
	end,
}
