return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "c_sharp",
        "ini",
        "lua",
        "json",
        "jsonc",
        "vim",
        "vimdoc",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    })

    vim.treesitter.language.register('ini', 'service')
  end,
}
