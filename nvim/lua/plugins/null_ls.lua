-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   null_ls.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/08/25 18:44:34 by pibouill          #+#    #+#             --
--   Updated: 2025/08/25 18:44:43 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    require("mason").setup({
      ensure_installed = {
        "checkmake",
      }
    })

    null_ls.setup({
      debug = false,
      sources = {
        -- null_ls.builtins.diagnostics.checkmake.with({
        --   filetypes = { "make", "makefile" },
        -- }),
      },
    })
  end,
}
