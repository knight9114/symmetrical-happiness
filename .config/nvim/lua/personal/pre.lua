-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Personal keymaps
vim.keymap.set("i", "jk", "<ESC>")

-- Enabling system clipboard
vim.api.nvim_command("set clipboard+=unnamedplus")

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

-- Bracket matching
vim.opt.showmatch = true
vim.opt.matchtime = 1

-- Terminal colors
vim.opt.termguicolors = true

-- Swap files
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Mouse
vim.o.mouse = "a"

-- Completion
vim.o.completeopt = "menuone,noselect"
