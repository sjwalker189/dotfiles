return {
  { 'folke/neodev.nvim', opts = {} },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim',                opts = {} },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local lsp = require("lsp-zero")
      local lspconfig = require("lspconfig")

      lsp.preset("recommended")

      lsp.ensure_installed({
        "html",
        "cssls",
        "tsserver",
        "eslint",
        "rust_analyzer",
        "gopls",
        "bashls",
        "lua_ls",
      })

      lsp.set_preferences({
        sign_icons = {
          error = '✘',
          warn = '▲',
          hint = '⚑',
          info = '»'
        }
      })

      lsp.on_attach(function(client, bufnr)
        require("swalker.config.lsp.core").on_attach(client, bufnr)
      end)

      lsp.configure('denols', {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })

      lsp.configure('tsserver', {
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        }
      })

      lsp.configure("volar", {
        cmd = { 'vue-language-server', '--stdio'},
        root_dir = lspconfig.util.root_pattern("package.json"),
        settings = {
          filetypes = {
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'vue',
            'json',
          },
        },
      })

      lsp.configure('rust_analyzer', {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            }
          }
        }
      })

      lsp.configure("lua-language-server", {
        Lua = {
          workspace = { checkThirdParty = false },
          telementary = { enable = false },
          diagnostics = {
            globals = { 'vim' },
          }
        }
      })

      -- Completions
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })

      cmp_mappings['<Tab>'] = nil
      cmp_mappings['<S-Tab>'] = nil

      lsp.setup_nvim_cmp({
        mapping = cmp_mappings
      })
      lsp.setup()
    end
  },
}
