return {
  {
    'stevearc/conform.nvim',
    config = function()
      local conform = require 'conform'
      local util = require 'conform.util'

      conform.setup {
        format = {
          timeout_ms = 3000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
          lsp_fallback = true,
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          sh = { 'shfmt' },
          php = { 'pint' },
          blade = { 'blade-formatter', 'rustywind' },
          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          vue = { 'prettierd' },
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
          pint = {
            meta = {
              url = 'https://github.com/laravel/pint',
              description = 'Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.',
            },
            command = util.find_executable({
              'vendor/bin/pint',
            }, 'pint'),
            args = { '$FILENAME' },
            stdin = false,
          },
        },
      }

      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        conform.format {
          async = true,
          lsp_fallback = true,
          range = range,
        }
      end, { range = true })

      vim.keymap.set('n', '<S-C-i>', '<CMD>Format<CR>', { desc = 'Format buffer', silent = true })
    end,
  },
}
