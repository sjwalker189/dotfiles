return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Additional lua configuration, makes nvim stuff amazing!
  'folke/neodev.nvim',

  'editorconfig/editorconfig-vim',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {}, lazy=true },

  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },
}
