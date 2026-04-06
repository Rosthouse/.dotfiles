-- configure tab settings
local tabWidth = 2

vim.opt.tabstop = tabWidth
vim.opt.softtabstop = tabWidth
vim.opt.shiftwidth = tabWidth
vim.opt.expandtab = true

vim.opt.smartindent = true


vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- looks
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.pumborder = 'rounded'
vim.opt.pummaxwidth = 40
vim.opt.completeopt = { "menuone", "menu", "noselect", "fuzzy" }
vim.o.autocomplete = true


-- Quickfix window
vim.g.dotnet_errors_only = true
vim.g.dotnet_show_project_file = false

