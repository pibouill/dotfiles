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

    local h = require("null-ls.helpers")
    null_ls.setup({
      debug = false,
      sources = {
        null_ls.builtins.diagnostics.checkmake.with({
          filetypes = { "make", "makefile" },
          generator_opts = {
            command = "checkmake",
            args = {
              "--format='{{.LineNumber}}:{{.Rule}}:{{.Violation}}'",
              "$FILENAME",
            },
            to_stdin = false,
            from_stderr = true, -- Capture stderr
            to_temp_file = true,
            format = "line",
            check_exit_code = function(code)
              -- checkmake exits with 1 on violations, 2 on error
              return code <= 1
            end,
            on_output = function(ctx)
              -- The "violations found" message is on the last line of stderr
              if ctx.is_stderr and ctx.line:match("violations found") then
                return
              end
              local row, code, message = ctx.line:match("^(%d+):(%w+):(.+)$")
              if row and code and message then
                return {
                  row = tonumber(row),
                  col = 1,
                  code = code,
                  message = message,
                  severity = vim.diagnostic.severity.WARN,
                }
              end
            end,
          },
        }),
      },
    })
  end,
}
