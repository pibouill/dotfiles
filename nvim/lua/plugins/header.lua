-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   header.lua                                         :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/01 11:02:17 by pibouill          #+#    #+#             --
--   Updated: 2024/12/01 11:02:17 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
    "vinicius507/ft_nvim",
    config = function()
        require("ft_nvim").setup({
            -- Configures the 42 Header integration
            header = {
                enable = true,
                username = "pibouill",
                email = "pibouill@student.42prague.com",
            },
            -- Configures the norminette integration
            norminette = {
                enable = false,
            },
        })
    end
}
