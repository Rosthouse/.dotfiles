return {
  {
    "neovim/nvim-lspconfig",
    config = function () 
      print("Hello from lsp")
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {},
  },
}
