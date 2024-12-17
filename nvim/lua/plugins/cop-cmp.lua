-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   cop-cmp.lua                                        :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/15 15:01:00 by pibouill          #+#    #+#             --
--   Updated: 2024/12/15 15:01:14 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"zbirenbaum/copilot-cmp",
	event = { "InsertEnter", "LspAttach" },
	fix_pairs = true,
	config = function ()
    require("copilot_cmp").setup()
  end
}
