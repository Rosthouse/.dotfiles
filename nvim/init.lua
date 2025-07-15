-- Start settings
require("config.conf")

vim.opt.langmap = "ü[,¨],è{,!}"


-- Disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Plugins
require("config.lazy")

require("config.keymaps")
require("config.late")
