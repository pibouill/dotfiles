-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   hover.lua                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2026/02/03 18:04:20 by pibouill          #+#    #+#             --
--   Updated: 2026/02/03 18:06:37 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --
 return {
 	"lewis6991/hover.nvim",
 	config = function()
 		require('hover').setup({
 			init = function()
 				-- Require providers
 				require('hover.providers.diagnostic')
 				require('hover.providers.lsp')
 				require('hover.providers.dap')
 				require('hover.providers.man')
 				require('hover.providers.dictionary')
 			end,
 			preview_opts = {
 				border = 'rounded',
				-- border = 'single',
				-- border = 'shadow',
				-- border = 'none',
 			},
 			-- Whether the contents of a currently open hover window should be moved
 			-- to a :h preview-window when pressing the hover keymap.
 			preview_window = false,
 			title = true,
 		})

 		-- Setup keymaps
 		vim.keymap.set('n', 'K', function()
 			require('hover').hover()
 		end, { desc = 'hover.nvim (hover)' })

 		vim.keymap.set('n', 'gK', function()
 			require('hover').hover_select({})
 		end, { desc = 'hover.nvim (select)' })

 		vim.keymap.set('n', '<C-p>', function()
 			require('hover').hover_switch('previous')
 		end, { desc = 'hover.nvim (previous source)' })

 		vim.keymap.set('n', '<C-n>', function()
 			require('hover').hover_switch('next')
 		end, { desc = 'hover.nvim (next source)' })

 	end
 }
