-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   conform.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/03 12:59:33 by pibouill          #+#    #+#             --
--   Updated: 2024/12/03 12:59:33 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
}
