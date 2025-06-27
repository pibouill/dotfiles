-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   hlsearch.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/06/26 11:59:43 by pibouill          #+#    #+#             --
--   Updated: 2025/06/26 12:02:07 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
    "nvimdev/hlsearch.nvim",
    config = function()
        require("hlsearch").setup()
    end
}
