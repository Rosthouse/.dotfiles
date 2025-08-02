return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      { "saghen/blink.cmp" },
    },
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })

      require("mason-lspconfig").setup()

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("bashls")
      vim.lsp.enable("omnisharp")

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })
    end,
  },
}
