-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   lazy-dev.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/03 12:30:11 by pibouill          #+#    #+#             --
--   Updated: 2024/12/03 12:30:11 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- lazydev.nvim is a plugin that properly configures LuaLS for editing your
-- Neovim config by lazily updating your workspace libraries.

return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "LazyVim", words = { "LazyVim" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "LazyVim" } },
    },
  },
}
