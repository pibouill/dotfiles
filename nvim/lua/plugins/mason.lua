-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   mason.lua                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/20 12:25:11 by pibouill          #+#    #+#             --
--   Updated: 2025/01/08 13:17:16 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
  opts = {
    -- UI customization
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
      width = 0.8,
      height = 0.8,
    },
    -- Only specify formatters and linters here
    -- LSP servers are defined in mason-lspconfig.lua
    ensure_installed = {
      "stylua",     -- Lua formatter
      "shfmt",      -- Shell formatter
    },
    -- Max concurrent installations
    max_concurrent_installers = 4,
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")

    -- Handle successful installations
    mr:on("package:install:success", function(pkg)
      vim.notify("Installed " .. pkg.name, vim.log.levels.INFO)
      vim.defer_fn(function()
        -- Trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    -- Install tools if missing
    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
