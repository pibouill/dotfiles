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
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    "williamboman/mason-lspconfig.nvim", -- Add mason-lspconfig for auto configuration
  },
  config = function()
    -- Automatically set up LSP servers using mason-lspconfig
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
      },
      automatic_installation = true, -- Auto install missing servers
    })

    -- Use mason-lspconfig to setup LSPs automatically
    mason_lspconfig.setup_handlers({
      function(server_name) -- Default handler for setting up servers
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        lspconfig[server_name].setup { capabilities }
      end,
    })

    -- Additional LSP setups, if needed
    lspconfig.lua_ls.setup {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    }
    lspconfig.clangd.setup {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    }
  end,
}
