return {
  {
    'camspiers/rocks',
    dependencies = {
      'rcarriga/nvim-notify',
    },
    opts = {
      rocks = { 'fzy' },
    },
  },
  {
    'camspiers/snap',
    dependencies = { 'camspiers/rocks' },
    config = function()
      local snap = require 'snap'
      local layout = snap.get 'layout'
      local args = { '--hidden', '--smart-case', '--iglob', '!.git/*' }

      local function centered()
        return layout['%centered'](0.95, 0.8)
      end

      local doubleArrow = '\194\187'
      local file = snap.config.file:with {
        reverse = true,
        consumer = pcall(require, 'fzy') and 'fzy' or 'fzf',
        layout = centered,
        prompt = '',
        suffix = doubleArrow
      }

      local vimgrep = snap.config.vimgrep:with {
        reverse = true,
        layout = centered,
        limit = 50000,
        prompt = '',
        suffix = doubleArrow,
      }

      snap.maps {
        { '<leader>ff', file({ producer = 'ripgrep.file', args = args }, { command = 'files' }) }, -- find all files
        { '<leader>fg', file { producer = 'git.file' }, { command = 'git.files' } }, -- find git files
        { '<leader>fb', file { producer = 'vim.buffer' }, { command = 'buffers' } }, -- find buffers
        { '<leader>fw', vimgrep {} }, -- find word
        {
          '<Leader>fo', -- find old file
          file {
            producer = 'vim.oldfile',
          },
          {
            command = 'oldfiles',
          },
        },
        {
          '<leader>fcw', -- find current  word
          vimgrep {
            filter_with = 'cword',
          },
          {
            command = 'currentwordgrep',
          },
        },
        {
          '<leader>fs', -- find selection
          vimgrep {
            filter_with = 'selection',
          },
          {
            command = 'currentwordgrep',
          },
        },
      }
    end,
  },
}
