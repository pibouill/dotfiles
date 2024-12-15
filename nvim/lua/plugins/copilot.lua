-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   copilot.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/15 13:21:43 by pibouill          #+#    #+#             --
--   Updated: 2024/12/15 13:25:51 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  config = function()
	  require("copilot").setup({
		suggestion = {
		  enabled = false,
		  auto_trigger = true,
		  keymap = {
			accept = false, -- handled by nvim-cmp / blink.cmp
			next = "<M-]>",
			prev = "<M-[>",
		  },
		},
		panel = { enabled = false },
		filetypes = {
		  markdown = true,
		  help = true,
		},
	  })
  end,
}
