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

        -- Override the header generation logic to fix the whitespace issue
        local ft_nvim = require("ft_nvim")
        local original_insert = ft_nvim.insert

        ft_nvim.insert = function(bufnr, opts)
            opts.email = string.gsub(opts.email, "%s<", "<") -- Fix email formatting
            original_insert(bufnr, opts)
        end
    end
}
