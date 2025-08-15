return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "saghen/blink.cmp" },
      { "Hoffs/omnisharp-extended-lsp.nvim" },
    },
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })

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

      vim.lsp.config("omnisharp",
        {
          handlers = {
            --            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
            --            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
            --            ["textDocument/references"] = require('omnisharp_extended').references_handler,
            --            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
          }
        })


      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
      vim.keymap.set("n", "gR", vim.lsp.buf.references, { buffer = 0 })
      vim.keymap.set("n", "gr", vim.lsp.buf.rename, { buffer = 0 })
      -- vim.keymap.set("n", "gf", vim.lsp.buf.formatting, { buffer = 0 })
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
      vim.keymap.set("n", "dn", vim.diagnostic.goto_next, { buffer = 0 })
      vim.keymap.set("n", "dp", vim.diagnostic.goto_prev, { buffer = 0 })
    end,
  },
}
