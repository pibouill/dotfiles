-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   oil.lua                                            :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/13 15:47:46 by pibouill          #+#    #+#             --
--   Updated: 2025/01/13 15:50:58 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "stevearc/oil.nvim",
  keys = {
    { "<leader>e", "<cmd>Oil --float<CR>", desc = "Explorer" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 5,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
