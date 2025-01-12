-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   lsp.lua                                            :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/15 15:23:48 by pibouill          #+#    #+#             --
--   Updated: 2024/12/18 14:13:19 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- list LSPs -> :help lspconfig-all
--
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		  {
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
			  library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			  },
			},
		  },
		},
	config = function()
		local capabilities = require('blink.cmp').get_lsp_capabilities()
		-- require("lspconfig").lua_ls.setup { capabilities }
		-- require("lspconfig").clangd.setup { capabilities }
		-- require("lspconfig").harper_ls.setup { capabilities }
		-- require("lspconfig").taplo.setup { capabilities }
	end,
}
