-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   treesitter.lua                                     :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/01/08 18:59:15 by pibouill          #+#    #+#             --
--   Updated: 2025/01/08 19:03:43 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  -- Treesitter core
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
				ensure_installed = {
					"lua",
					"c",
					"cpp",
					"vim",
					"vimdoc",
					"python",
					"make",
					"bash",
				},
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
        -- textobjects config can go here, or in the textobjects plugin block
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]f"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[f"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      }
    end,
  },

  -- Treesitter textobjects (no need for custom require hacks)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    enabled = true,
    -- No config needed if you configure textobjects in the main block above!
  },

  -- Autotag for HTML/JSX/etc.
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  },
}
