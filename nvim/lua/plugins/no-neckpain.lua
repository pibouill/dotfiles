-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   no-neckpain.lua                                    :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/23 09:21:53 by pibouill          #+#    #+#             --
--   Updated: 2025/01/23 09:21:56 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	{
		"shortcuts/no-neck-pain.nvim",
		cmd = "NoNeckPain",
		opts = {
			width = 130,
		},
		keys = {
			{ "<leader>nn", "<cmd>NoNeckPain<cr>"},
			{ "<leader>nN", "<cmd>NoNeckPainResize 130<cr>"},
		},
	},
}
