-- Visual Setting
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"

-- Add Relative Number
vim.opt.nu = true
vim.opt.relativenumber = true

-- Track Cursor
vim.opt.scrolloff = 8

-- Tab Settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Remove Word Wrap
vim.opt.wrap = false

-- Remove Backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Add Undo Function
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search Settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Performance
vim.opt.updatetime = 50
