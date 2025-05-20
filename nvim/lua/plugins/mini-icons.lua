-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   mini-icons.lua                                     :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/13 07:36:27 by pibouill          #+#    #+#             --
--   Updated: 2024/12/13 07:36:31 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return
{
  "echasnovski/mini.icons",
  lazy = true,
  opts = {
    file = {
      [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
      dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  { "MunifTanjim/nui.nvim", lazy = true },
}
