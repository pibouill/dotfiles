-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   bufferline.lua                                     :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/03 12:39:08 by pibouill          #+#    #+#             --
--   Updated: 2024/12/03 12:39:08 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "akinsho/bufferline.nvim",
  optional = true,
  opts = function(_, opts)
    if (vim.g.colors_name or ""):find("catppuccin") then
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end
  end,
}
