return {
  {
    -- Syntax highlightng for .blade.php files
    'jwalton512/vim-blade',
  },
  -- {
  --   'adalessa/laravel.nvim',
  --   dependencies = {
  --     'tpope/vim-dotenv',
  --     'MunifTanjim/nui.nvim',
  --   },
  --   cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Laravel' },
  --   keys = {
  --     { '<leader>la', ':Laravel artisan<cr>' },
  --     { '<leader>lr', ':Laravel routes<cr>' },
  --     { '<leader>lm', ':Laravel related<cr>' },
  --     {
  --       '<leader>lt',
  --       function()
  --         require('laravel.tinker').send_to_tinker()
  --       end,
  --       mode = 'v',
  --       desc = 'Laravel Application Routes',
  --     },
  --   },
  --   event = { 'VeryLazy' },
  --   config = function()
  --     require('laravel').setup {
  --       bind_telescope = false, -- we're using snap search
  --       lsp_server = 'phpactor',
  --     }
  --   end,
  -- },
}
