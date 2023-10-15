return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Additional lua configuration, makes nvim stuff amazing!
  'folke/neodev.nvim',

  'editorconfig/editorconfig-vim',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Laravel Blade
  { 'jwalton512/vim-blade' },

  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    -- TODO: Keymaps
    -- "<C-h>" = "<cmd>TmuxNavigateLeft<CR>"
    -- "<C-l>" = "<cmd>TmuxNavigateRight<CR>"
    -- "<C-j>" = "<cmd>TmuxNavigateDown<CR>"
    -- "<C-k>" = "<cmd>TmuxNavigateUp<CR>"
  },
}
