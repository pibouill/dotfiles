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
  {
	  "nvim-treesitter/nvim-treesitter",
	  version = false,
	  build = ":TSUpdate",
	  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	  lazy = vim.fn.argc() > 0,
	  init = function(plugin)
		  local lazy_core = require("lazy.core.loader")
		  lazy_core.add_to_rtp(plugin)
		  require("nvim-treesitter.query_predicates")
	  end,
	  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	  keys = {
		  { "<c-space>", desc = "Increment Selection" },
		  { "<bs>", desc = "Decrement Selection", mode = "x" },
	  },
	  opts_extend = { "ensure_installed" },
	  ---@type TSConfig
	  ---@diagnostic disable-next-line: missing-fields
	  opts = {
		  ensure_installed = {
			  "bash", "c", "cpp", "diff", "python", "html", "javascript",
			  "json", "lua", "luadoc", "luap", "markdown", "markdown_inline",
			  "regex", "toml", "vim", "vimdoc"
		  },
		  highlight = { enable = true },
		  indent = { enable = true },
		  incremental_selection = {
			  enable = true,
			  keymaps = {
				  init_selection = "<C-space>",
				  node_incremental = "<C-space>",
				  scope_incremental = false,
				  node_decremental = "<bs>",
			  },
		  },
		  textobjects = {
			  move = {
				  enable = true,
				  goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
				  goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
				  goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
				  goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
			  },
		  },
	  },
	  ---@param opts TSConfig
	  config = function(opts, _)
		  require("nvim-treesitter.configs").setup(opts)
		  vim.api.nvim_create_autocmd("InsertEnter", {
			  pattern = "*",
			  callback = function()
				  if vim.fn.line("$") > 10000 then
					  vim.cmd("TSDisable highlight")
				  end
			  end,
		  })
		  vim.api.nvim_create_autocmd("InsertLeave", {
			  pattern = "*",
			  callback = function()
				  if vim.fn.line("$") > 10000 then
					  vim.cmd("TSEnable highlight")
				  end
			  end,
		  })
	  end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  },
}
