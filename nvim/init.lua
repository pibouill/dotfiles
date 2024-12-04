-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   init.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/01 10:55:23 by pibouill          #+#    #+#             --
--   Updated: 2024/12/01 10:55:23 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

require("config.keymaps")
require("config.lazy")

-- available = rose-pine, gruvbox, catppucin
-- -> check colorscheme.lua
vim.cmd [[colorscheme catppuccin]]
