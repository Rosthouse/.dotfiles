vim.opt.nu = true                 -- Setting line numbers
vim.opt.relativenumber = true     -- Line numbers are relative

local tabWidth = 2

vim.opt.tabstop = tabWidth
vim.opt.softtabstop = tabWidth
vim.opt.shiftwidth = tabWidth
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = ' '
vim.g.maplocalleader = 'ö'

