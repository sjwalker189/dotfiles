return {
  {
    'kvrohit/mellow.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'mellow'
    end,
  },
}
