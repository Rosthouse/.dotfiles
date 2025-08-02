-- Start settings
require("config.conf")
require("config.keymaps")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugins
require("config.lazy")
require("config.late")

require("config.godot")
