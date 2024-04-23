local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('lazy').setup {
  -- Base
  { 'folke/neodev.nvim', opts = {} },
  { 'editorconfig/editorconfig-vim' },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Code comments
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- Colorscheme
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   opts = {
  --     compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
  --   },
  --   init = function()
  --     vim.cmd 'colorscheme catppuccin-mocha'
  --   end,
  -- },

  {
    'tjdevries/colorbuddy.nvim',
    priority = 1000,
    config = function()
      local colorbuddy = require 'colorbuddy'
      local Color = colorbuddy.Color
      local Group = colorbuddy.Group
      local c = colorbuddy.colors
      local g = colorbuddy.groups
      local s = colorbuddy.styles

      -- Set base color scheme
      vim.cmd.colorscheme 'gruvbuddy'

      -- Customise color scheme by re-defining colors and groups
      local background_string = '#121317'
      Color.new('background', background_string)
      Color.new('gray0', background_string)

      Group.new('LineNr', c.gray1:light(), c.gray0)
      Group.new('CursorLine', nil, g.normal.bg:light(0.025))
      Group.new('StatusLine', c.gray2, c.background, nil)
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = { 'branch', 'diagnostics', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'location' },
        lualine_z = {},
      },
    },
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy [G]it', mode = { 'n' } },
    },
  },

  -- Completions
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Completion sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Add pictograms to LSP completions
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        -- Enabled except when in comments
        enabled = function()
          local context = require 'cmp.config.context'
          return not (context.in_treesitter_capture 'comment' == true or context.in_syntax_group 'Comment')
        end,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        formatting = {
          format = function(entry, vim_item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return require('lspkind').cmp_format {}(entry, vim_item)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        }),
      }
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },

  -- Syntax Highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require 'nvim-treesitter.query_predicates'
    end,
    dependencies = {
      { 'windwp/nvim-ts-autotag' }, -- Autopairs for html tags
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require 'nvim-treesitter.textobjects.move' ---@type table<string,fun(...)>
          local configs = require 'nvim-treesitter.configs'
          for name, fn in pairs(move) do
            if name:find 'goto' == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module('textobjects.move')[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find '[%]%[][cC]' then
                      vim.cmd('normal! ' .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    keys = {
      { '<c-space>', desc = 'Increment selection' },
      { '<bs>', desc = 'Decrement selection', mode = 'x' },
    },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        'typescript',
        'javascript',
        'tsx',
        'vue',
        'css',
        'bash',
        'diff',
        'html',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
        'go',
        'gomod',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim' },
    },
    config = function()
      require('neodev').setup {}

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local util = require 'lspconfig/util'

      local servers = {
        lua_ls = {
          capabilities = capabilities,
        },
        gopls = {
          capabilities = capabilities,
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        },
        html = {
          capabilities = capabilities,
          filetypes = { 'html', 'vue' },
        },
        cssls = {
          capabilities = capabilities,
          settings = {
            validate = true,
            lint = {
              -- For tailwindcss
              unknownAtRules = 'ignore',
            },
          },
        },
        tailwindcss = {
          capabilities = capabilities,
        },
        tsserver = {
          capabilities = capabilities,
        },
        volar = {
          capabilities = capabilities,
        },
        eslint = {
          capabilities = capabilities,
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = 'if_many',
            prefix = '●',
          },
          severity_sort = true,
        },
        inlay_hints = {
          enabled = false,
        },
      }

      -- Register the LSP servers
      for server, config in pairs(servers) do
        require('lspconfig')[server].setup(config)
      end

      -- Connect keymaps when LSP servers attach to buffers
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v', 'i' }, '<C-.>', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end,
      })
    end,
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<S-C-i>',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      format_on_save = { timeout_ms = 200, lsp_fallback = true },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        vue = { { 'prettierd', 'prettier' } },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- Fuzzy finding
  {
    'camspiers/luarocks',
    lazy = true,
    dependencies = { 'rcarriga/nvim-notify' },
    opts = {
      rocks = { 'fzy' },
    },
  },
  {
    'camspiers/snap',
    dependencies = 'camspiers/luarocks',
    config = function()
      local snap = require 'snap'

      local defaults = { prompt = '', suffix = '»' }
      local file = snap.config.file:with(defaults)
      local vimgrep = snap.config.vimgrep:with(vim.tbl_extend('force', defaults, {
        limit = 20000,
      }))

      snap.maps {
        {
          '<leader>ff',
          file { producer = 'ripgrep.file', args = { '--hidden', '--iglob', '!.git/*' } },
          command = 'files',
        },
        { '<leader>fb', file { producer = 'vim.buffer' }, { command = 'buffers' } },
        { '<leader>fo', file { producer = 'vim.oldfile' }, { command = 'oldfiles' } },
        { '<leader>fg', vimgrep {}, { command = 'grep' } },
        { '<leader>fw', vimgrep { filter_with = 'cword' }, { command = 'currentwordgrep' } },
      }

      -- Theme
      vim.api.nvim_set_hl(0, 'SnapBorder', { fg = '#5B6078' })
    end,
  },
  -- {
  --   'ThePrimeagen/git-worktree.nvim',
  --   config = function()
  --     require('git-worktree').setup {}
  --   end,
  -- },
  -- {
  --   'ThePrimeagen/harpoon',
  --   branch = 'harpoon2',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     local harpoon = require 'harpoon'
  --
  --     harpoon:setup {}
  --
  --     vim.keymap.set('n', '<leader>a', function()
  --       harpoon:list():append()
  --     end)
  --     vim.keymap.set('n', '<C-e>', function()
  --       harpoon.ui:toggle_quick_menu(harpoon:list())
  --     end)
  --
  --     vim.keymap.set('n', '<leader>1', function()
  --       harpoon:list():select(1)
  --     end)
  --     vim.keymap.set('n', '<leader>2', function()
  --       harpoon:list():select(2)
  --     end)
  --     vim.keymap.set('n', '<leader>3', function()
  --       harpoon:list():select(3)
  --     end)
  --     vim.keymap.set('n', '<leader>4', function()
  --       harpoon:list():select(4)
  --     end)
  --
  --     -- Toggle previous & next buffers stored within Harpoon list
  --     vim.keymap.set('n', '<Tab>', function()
  --       harpoon:list():prev()
  --     end)
  --     vim.keymap.set('n', '<S-Tab>', function()
  --       harpoon:list():next()
  --     end)
  --   end,
  -- },
  {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Block cursor always
vim.opt.guicursor = ''
vim.opt.cursorline = true

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Show numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Show at least 20 lines always
vim.opt.scrolloff = 20

-- Always split down or right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Hide netrw stuff
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- [[ Keymaps ]]

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Make current file executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Save buffer
vim.keymap.set('n', '<C-s>', '<CMD>update<CR>', { desc = '[S]ave File' })

-- Mirror terminal escape
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Window Navigations
vim.keymap.set('n', '<C-Left>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { silent = true })

vim.keymap.set('n', '-', '<CMD>Ex<CR>', {})

-- [[ AutoCommands ]]
--
local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
