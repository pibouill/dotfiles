-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   norminette.lua                                     :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/06 13:07:25 by pibouill          #+#    #+#             --
--   Updated: 2024/12/06 13:08:39 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
	"vinicius507/norme.nvim",
	dependencies = { "nvimtools/none-ls.nvim" },
	-- event = { "BufReadPre *.c", "BufReadPre *.h" },
	config = function ()
		require("norme").setup({
			-- Your configuration
			-- cmd = os.getenv('HOME') .. '/usr/bin/norminette'
			cmd = 'norminette'
		})
	end,
	keys = { { "<leader>no", "<cmd>NormeToggle<cr>"}},
}
