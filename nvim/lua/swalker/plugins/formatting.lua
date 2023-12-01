return {
  {
    'mhartington/formatter.nvim',
    lazy = true,
    config = function()
      local util = require 'formatter.util'
      local prettierd = require 'formatter.defaults.prettierd'

      -- Formatters
      require('formatter').setup {
        log_level = vim.log.levels.WARN,
        filetype = {
          lua = { require('formatter.filetypes.lua').stylua },

          -- Web development
          php = { require('formatter.filetypes.php').php_cs_fixer },
          css = { util.withl(prettierd, 'css') },
          vue = { util.withl(prettierd, 'vue') },
          javascript = { util.withl(prettierd, 'javascript') },
          javascriptreact = { util.withl(prettierd, 'javascriptreact') },
          typescript = { util.withl(prettierd, 'typescript') },
          typescriptreact = { util.withl(prettierd, 'typescriptreact') },
          json = { util.withl(prettierd, 'json') },
          ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      }

      -- Keymaps
      vim.keymap.set('n', '<S-C-i>', '<CMD>Format<CR>', { desc = 'Format buffer', silent = true })
    end,
  },
}
