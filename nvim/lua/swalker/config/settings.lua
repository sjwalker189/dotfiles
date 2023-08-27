vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.grepprg = "rg --no-heading --vimgrep --hidden --iglob '!.DS_Store' --iglob '!.git'"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Make line numbers default
vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.wo.number = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Wrapping etc
vim.opt.scrolloff = 20

-- vim.opt.isfname:append("@-@")
-- vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append{ '*/node_modules/*', '*/vendor/*' }
vim.opt.colorcolumn = "81,121"
vim.opt.wrap = false
vim.opt.autowrite = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


vim.opt.modeline = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.magic = true

