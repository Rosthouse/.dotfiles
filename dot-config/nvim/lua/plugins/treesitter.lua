return {
  {
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
  },
  {
    'Thiago4532/mdmath.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },

    -- The build is already done by default in lazy.nvim, so you don't need
    -- the next line, but you can use the command `:MdMath build` to rebuild
    -- if the build fails for some reason.
    -- build = ':MdMath build'
  },
}
