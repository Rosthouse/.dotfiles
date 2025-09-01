-- Start settings
require("config.conf")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugins
require("config.lazy")
require("config.late")

require("config.godot")
