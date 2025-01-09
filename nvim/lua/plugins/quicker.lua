-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   quicker.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/09 09:10:10 by pibouill          #+#    #+#             --
--   Updated: 2025/01/09 09:14:04 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  'stevearc/quicker.nvim',
  event = "FileType qf",
  vim.keymap.set("n", "<leader>q", function()
	  require("quicker").toggle()
  end, {
  desc = "Toggle quickfix",
  }),
  vim.keymap.set("n", "<leader>Q", function()
	  require("quicker").toggle({ loclist = true })
  end, {
  desc = "Toggle loclist",
  }),
  config = function()
    -- Setup quicker.nvim
    require("quicker").setup({})
  end,
}
