-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   mason-lspconfig.lua                                :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/08 13:16:28 by pibouill          #+#    #+#             --
--   Updated: 2025/01/08 13:16:47 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    "mason-org/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- Configure diagnostics display
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
		})

		-- Server-specific configurations
		local server_settings = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
				},
			},
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local bufnr = ev.buf
				vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
				-- Key mappings for LSP features
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to declaration" })
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Go to references" })
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename symbol" })
				vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code action" })
				vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { buffer = bufnr, desc = "LSP: Show diagnostics" })
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = "LSP: Previous diagnostic" })
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = "LSP: Next diagnostic" })
			end,
		})

		-- Setup all servers with common config + server-specific settings
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"bashls",
			},
			handlers = {
				function(server_name)
					local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
					if not ok_lspconfig then
						vim.notify("Failed to load lspconfig", vim.log.levels.ERROR)
						return
					end

					local opts = {
						capabilities = capabilities,
					}
					if server_settings[server_name] then
						opts = vim.tbl_deep_extend("force", opts, server_settings[server_name])
					end
					lspconfig[server_name].setup(opts)
				end,
			},
		})
	end,
}
