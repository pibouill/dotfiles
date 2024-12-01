-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   header.lua                                         :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/01 10:35:17 by pibouill          #+#    #+#             --
--   Updated: 2024/12/01 10:35:17 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
    "vinicius507/ft_nvim",
    config = function()
        require("ft_nvim").setup({
            -- Configures the 42 Header integration
            header = {
                -- Enable the 42 Header integration (default: true)
                enable = true,
                -- Your Intranet username
                username = "pibouill",
                -- Your Intranet email
                email = "pibouill@student.42prague.com",
            },
            -- Configures the norminette integration
            norminette = {
                -- Enable the norminette integration (default: true)
                enable = false,
            },
        })
    end
}
