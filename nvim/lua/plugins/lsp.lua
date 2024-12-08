return {
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body) -- Replace with your snippet engine.
          end,
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


-- Pairs chars -> not sure about it
{
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { "string" },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
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
