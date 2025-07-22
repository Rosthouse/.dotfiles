return{
  "nvim-treesitter/nvim-treesitter",
  build = ':TSUpdate',
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        'c',
        'c_sharp',
        'lua',
        'vim',
        'vimdoc',
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    })
  end
}
