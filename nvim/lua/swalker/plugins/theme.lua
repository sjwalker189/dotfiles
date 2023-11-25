return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        -- transparent_background = true,
        compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
      }
      vim.cmd 'colorscheme catppuccin-macchiato'
    end,
  },
}
