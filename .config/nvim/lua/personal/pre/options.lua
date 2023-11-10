-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Scrolling
vim.opt.scrolloff = 4

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indenting
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Matching
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- GUI
vim.opt.termguicolors = true

-- Swapfile
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
