-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   blink-cmp.lua                                      :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/18 14:04:54 by pibouill          #+#    #+#             --
--   Updated: 2024/12/18 14:06:28 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',

  version = 'v0.*',

  opts = {
    keymap = { preset = 'default' },

	completion = {
		menu = {
			-- auto_show = false
		},
		ghost_text = { enabled = true },
	},
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    signature = { enabled = true },
  }
}
