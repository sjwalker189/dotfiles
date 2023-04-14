-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
-- vim.o.breakindent = false

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Wrapping etc
vim.opt.scrolloff = 15
vim.opt.colorcolumn = "120"
vim.opt.wrap = false
vim.opt.autowrite = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitright = true
