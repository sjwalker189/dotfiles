return {

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc, opts)
          if desc then
            desc = 'LSP: ' .. desc
          end

          local local_opts = { buffer = bufnr, desc = desc }

          if opts then
            for k, v in pairs(opts) do
              local_opts[k] = v
            end
          end

          vim.keymap.set('n', keys, func, local_opts)
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        -- Keymaps
        vim.keymap.set('n', '<S-C-i>', '<CMD>Format<CR>', { desc = 'Format buffer', silent = true })
      end

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      local lsp_handler_defaults = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
      }

      local with_defaults = function(lsp_handler_config)
        return function(server)
          require('lspconfig')[server].setup(vim.tbl_extend('force', lsp_handler_defaults, lsp_handler_config or {}))
        end
      end

      mason_lspconfig.setup {
        automatic_installation = false,
        ensure_installed = {
          -- Web development
          'html',
          'eslint',
          'volar',

          -- Common
          'lua_ls',
          'bashls',
        },
        handlers = {
          --
          -- Web Development
          --
          html = with_defaults {
            filetypes = { 'html', 'twig', 'hbs' },
          },

          eslint = with_defaults {
            settings = {
              workingDirectory = { mode = 'auto' },
            },
          },

          volar = with_defaults {
            filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue', 'json' },
            settings = {
              workingDirectory = { mode = 'auto' },
            },
          },

          --
          -- Other languages
          --
          lua_ls = with_defaults {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          },
          bashls = with_defaults {},
        },
      }
    end,
  },
}
