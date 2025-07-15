-- Start settings
require("config.conf")

vim.opt.langmap = "ü[,¨],è{,!}"

-- Plugins
require("config.lazy")

require("config.keymaps")
require("config.late")
