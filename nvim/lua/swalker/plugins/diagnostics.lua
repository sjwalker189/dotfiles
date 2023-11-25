return {
  {
    'folke/trouble.nvim',
    lazy = true,
    config = function()
      require('trouble').setup {
        icons = true,
        multiline = true,
        use_diagnostic_signs = true,
      }

      vim.keymap.set('n', '<leader>xx', function()
        require('trouble').toggle()
      end)
      vim.keymap.set('n', '<leader>xw', function()
        require('trouble').toggle 'workspace_diagnostics'
      end)
      vim.keymap.set('n', '<leader>xd', function()
        require('trouble').toggle 'document_diagnostics'
      end)
      vim.keymap.set('n', '<leader>xq', function()
        require('trouble').toggle 'quickfix'
      end)
      vim.keymap.set('n', '<leader>xl', function()
        require('trouble').toggle 'loclist'
      end)
      vim.keymap.set('n', 'gR', function()
        require('trouble').toggle 'lsp_references'
      end)

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end,
  },
}
