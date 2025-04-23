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

-- File epxlorer

return {
  "stevearc/oil.nvim",
  keys = {
    { "<leader>e", "<cmd>Oil --float<CR>", desc = "Explorer" },
  },
  opts = {
	  skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
	  natural_order = 'fast',
	  case_insensitive = false,
    },
    float = {
      padding = 2,
	  max_width = 190,
	  max_height = 0,
	  get_win_title = nil,
	  preview_split = "auto",
	  override = function (conf)
		  return conf
	  end,
    },
	preview_win = {
		update_on_cursor_moved = true,
	},
	keymaps = {
		["q"] = "actions.close",
	}
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
