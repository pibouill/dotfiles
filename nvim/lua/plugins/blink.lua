-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   blink.lua                                          :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/15 13:28:39 by pibouill          #+#    #+#             --
--   Updated: 2024/12/15 13:28:49 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = { "giuxtaposition/blink-cmp-copilot" },
  opts = {
    sources = {
      default = { "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          kind = "Copilot",
        },
      },
    },
  },
}
