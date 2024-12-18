-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   fugitive.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/18 11:28:32 by pibouill          #+#    #+#             --
--   Updated: 2024/12/18 11:54:49 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- '-' to stage files
-- '=' to open diff
-- 'enter' to open file in buffer
-- ':Gvdiffsplit' to open diff in buffer
return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	}
}
