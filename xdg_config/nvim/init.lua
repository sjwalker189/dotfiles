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

  {
    'tjdevries/colorbuddy.nvim',
    config = function()
      vim.cmd.colorscheme 'gruvbuddy'

      local colorbuddy = require 'colorbuddy'

      local Color = colorbuddy.Color
      local Group = colorbuddy.Group
      local c = colorbuddy.colors
      local g = colorbuddy.groups
      local s = colorbuddy.styles

      Color.new('black', '#000000')
      Color.new('white', '#f2e5bc')
      Color.new('red', '#cc6666')
      Color.new('pink', '#fef601')
      Color.new('green', '#99cc99')
      Color.new('yellow', '#fde68a')
      Color.new('blue', '#81a2be')
      Color.new('aqua', '#8ec07c')
      Color.new('cyan', '#8abeb7')
      Color.new('purple', '#8e6fbd')
      Color.new('violet', '#b294bb')
      Color.new('orange', '#de935f')
      Color.new('brown', '#a3685a')

      Color.new('seagreen', '#698b69')
      Color.new('turquoise', '#698b69')

      local background_string = '#121317'
      local comment_string = '#576a6e'

      Color.new('background', background_string)
      Color.new('gray0', background_string)
      Color.new('comment', comment_string)

      Group.new('Normal', c.superwhite, c.gray0)
      Group.new('Comment', c.comment, nil, s.italic)
      Group.new('CursorLine', nil, g.normal.bg:light(0.025))
      Group.new('StatusLine', c.softwhite, c.background, nil)

      Group.new('@constant', c.orange, nil, s.none)

      Group.new('@function', c.yellow, g.Normal, g.Normal)
      Group.new('@function.bracket', c.gray3, g.Normal, g.Normal)

      Group.new('@keyword', c.violet, nil, s.none)
      Group.new('@keyword.faded', g.nontext.fg:light(), nil, s.none)

      Group.new('@property', c.blue)

      Group.new('@variable', c.superwhite, nil)
      Group.new('@variable.member', c.blue)
      Group.new('@variable.member.vue', c.violet, g.Normal)
      Group.new('@variable.builtin', c.purple:light():light(), g.Normal)

      Group.new('@tag.attribute', c.violet, g.Normal)
      Group.new('@tag.delimiter', c.blue:light())

      Group.new('@punctuation.bracket', c.gray4)
      Group.new('@punctuation.special.vue', g.variable)

      Group.new('WinSeparator', c.gray2)
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
        lualine_a = { 'mode' },
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
        'templ',
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

      vim.filetype.add { extension = { templ = 'templ' } }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = {
        lua_ls = {
          capabilities = capabilities,
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
              -- For tailwindcss @apply
              unknownAtRules = 'ignore',
            },
          },
        },
        tailwindcss = {
          capabilities = capabilities,
          filetypes = { 'templ', 'javascript', 'typescript', 'react', 'vue' },
          init_options = { userLanguages = { templ = 'html' } },
        },
        tsserver = {
          capabilities = capabilities,
          filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'react', 'vue' },
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                -- Location of @vue/typescript-plugin
                location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin',
                languages = { 'javascript', 'typescript', 'vue' },
              },
            },
          },
        },
        volar = {
          capabilities = capabilities,
        },
        eslint = {
          capabilities = capabilities,
        },

        -- Go
        gopls = {
          capabilities = capabilities,
        },
        templ = {
          capabilities = capabilities,
          filetypes = { 'html', 'templ' },
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

      local mode = {
        n = 'n',
        v = 'v',
        i = 'i',
        x = 'x',
        all = { 'n', 'v', 'i', 'x' },
      }

      -- Connect keymaps when LSP servers attach to buffers
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set(mode.n, 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set(mode.n, 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set(mode.n, 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set(mode.n, '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set(mode.n, '<C-T>', vim.lsp.buf.type_definition, opts)
          vim.keymap.set(mode.n, '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set(mode.n, '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set(mode.all, '<C-.>', vim.lsp.buf.code_action, opts)
          vim.keymap.set(mode.all, '<F3>', vim.lsp.buf.code_action, opts)
          vim.keymap.set(mode.n, 'gr', vim.lsp.buf.references, opts)
        end,
      })

      -- Add templ support
      vim.filetype.add { extension = { templ = 'templ' } }
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
    opts = { rocks = { 'fzy' } },
  },
  {
    'camspiers/snap',
    dependencies = { 'camspiers/luarocks' },
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
        { '<leader>fr', file { producer = 'vim.oldfile' }, { command = 'oldfiles' } },
        { '<leader>fg', vimgrep {}, { command = 'grep' } },
        { '<leader>fw', vimgrep { filter_with = 'cword' }, { command = 'currentwordgrep' } },
      }

      -- Theme
      vim.api.nvim_set_hl(0, 'SnapBorder', { fg = '#5B6078' })
    end,
  },
  {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  },

  -- UI Replacements
  {
    'stevearc/dressing.nvim',
    opts = {},
    config = function()
      require('dressing').setup {
        select = {
          get_config = function(opts)
            if opts.kind == 'codeaction' then
              return {
                backend = 'nui',
                nui = {
                  relative = 'cursor',
                  max_width = 40,
                },
              }
            end
          end,
        },
      }
    end,
  },

  -- Prevent buffers from being opened in quickfix list and other secondary window types
  {
    'stevearc/stickybuf.nvim',
    opts = {},
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

-- Mode displayed in statusbar
vim.opt.showmode = false

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

-- Don't have `o` add a comment
vim.opt.formatoptions:remove 'o'

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
