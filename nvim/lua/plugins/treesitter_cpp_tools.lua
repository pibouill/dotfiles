-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   treesitter_cpp_tools.lua                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/05/30 16:59:09 by pibouill          #+#    #+#             --
--   Updated: 2026/01/20 12:13:35 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- Optional: Configuration
    opts = function()
        local options = {
            preview = {
                quit = "q", -- optional keymapping for quit preview
                accept = "<tab>", -- optional keymapping for accept preview
            },
            header_extension = "hpp", -- optional
            source_extension = "cpp", -- optional
            custom_define_class_function_commands = { -- optional
                TSCppImplWrite = {
                    output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
                },
            },
        }
        return options
    end,
    config = true,
}
