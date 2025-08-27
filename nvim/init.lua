-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   init.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/02/06 08:08:50 by pibouill          #+#    #+#             --
--   Updated: 2025/02/06 08:08:53 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

require("config.lazy")
require("config.keymaps")
require("config.options")

-- available = rose-pine, gruvbox-material, catppucin, kanagawa
----> check colorscheme.lua
vim.cmd [[colorscheme gruvbox-material]]
-- vim.cmd [[colorscheme rose-pine]]
-- vim.cmd [[colorscheme catppuccin]]
