-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   lsp.lua                                            :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/12/15 15:23:48 by pibouill          #+#    #+#             --
--   Updated: 2024/12/15 15:26:47 by pibouill         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

return {
  -- Autocompletion
  {
	  'hrsh7th/nvim-cmp',
	  event = 'InsertEnter',
	  config = function()
		local cmp = require('cmp')
		local lspkind = require('lspkind')

		-- Function to check if there are words before the cursor
		local has_words_before = function()
		  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
		  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
		end

		cmp.setup({
		  sources = {
			{ name = 'nvim_lsp' },
			-- { name = 'copilot', group_index = 2 },
			{ name = 'path', group_index = 2 },
			{ name = 'luasnip', group_index = 2 },
		  },
		  mapping = cmp.mapping.preset.insert({
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-u>'] = cmp.mapping.scroll_docs(-4),
			['<C-d>'] = cmp.mapping.scroll_docs(4),
			["<Tab>"] = vim.schedule_wrap(function(fallback)
			  if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			  else
				fallback()
			  end
			end),
		  }),
			--  snippet = {
			-- expand = function(args)
			--   vim.fn["vsnip#anonymous"](args.body) -- Replace with your snippet engine, e.g., luasnip or vsnip.
			-- end,
			--  },
		  formatting = {
			format = lspkind.cmp_format({
			  mode = 'symbol',
			  maxwidth = 50, -- Maximum width of menu items
			  ellipsis_char = '...', -- Truncated text will be replaced with ellipsis
			}),
			expandable_indicator = false,
			fields = { cmp.ItemField.Abbr, cmp.ItemField.Menu },
		  },
		  sorting = {
			priority_weight = 2,
			comparators = {

			  -- Below is the default comparitor list and order for nvim-cmp
			  cmp.config.compare.offset,
			  -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			  cmp.config.compare.exact,
			  cmp.config.compare.score,
			  cmp.config.compare.recently_used,
			  cmp.config.compare.locality,
			  cmp.config.compare.kind,
			  cmp.config.compare.sort_text,
			  cmp.config.compare.length,
			  cmp.config.compare.order,
			},
		  },
		})
	  end,
	},
  {
	  "nvim-cmp",
	  optional = true,
	  dependencies = {
		{
		  "garymjr/nvim-snippets",
		  opts = {
			friendly_snippets = true,
		  },
		},
		{ "rafamadriz/friendly-snippets" },
		{
		  "chrisgrieser/cmp_yanky",
		  config = function()
			require('cmp').setup {
			  sources = {
				{
				  name = 'cmp_yanky',
				  option = {
					onlyCurrentFiletype = false,
					minLength = 3,
				  },
				},
			  },
			}
		  end,
		},
	  },
},

  -- Mason and Mason-LSPConfig
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
      require('mason-lspconfig').setup({
		  install_root_dir = vim.fn.stdpath('data') .. '/mason-local',
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
            },
        },
    },
			})
          end,
        },
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
	opts = {
		setup = {
			-- fix clangd offset encoding
			clangd = function(_, opts)
				opts.capabilities.offsetEncoding = { "utf-16" }
			end,
		},
	},
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' },
    },
    init = function()
      -- Reserve a space in the gutter
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      -- These are just examples. Replace them with the language
      -- servers you have installed in your system
      -- require('lspconfig').gleam.setup({})
      -- require('lspconfig').ocamllsp.setup({})
    end,
  },
  {
	  "fyusuf-a/norminette-lsp"
  },
}
