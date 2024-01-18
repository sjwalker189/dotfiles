return {
  -- Detect tatically
  'tpope/vim-sleuth',

  -- Additional lua configuration, makes nvim stuff amazing!
  'folke/neodev.nvim',

  'editorconfig/editorconfig-vim',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
