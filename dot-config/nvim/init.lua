-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "


-- Start settings
require("config.conf")
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"

-- Loading configs
require("config.keymaps")
