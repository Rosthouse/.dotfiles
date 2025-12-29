return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { path = "${3rd}/luv/library", words = { "vim%.uv" } }
    },
  },
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        "seblyng/roslyn.nvim",
      },
    },
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
        },
      })

      vim.lsp.config("*", {
        -- capabilities = capabilities,
        root_markers = { ".git" },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          venvPath = ".venv",
          venv = "venv",
        }
      })

      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
        on_attach = function()
          vim.cmd("compiler dotnet")
        end
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("bashls")
      vim.lsp.enable("roslyn_ls")

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

          if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
            vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
            vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
            vim.keymap.set("i", "<CR>", [[pumvisible() ? "\<C-y>" : "\<CR>"]], { noremap = true, expr = true })
          end
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>flr", builtin.lsp_references, { desc = "References" })
          vim.keymap.set("n", "<leader>fli", builtin.lsp_incoming_calls, { desc = "Incoming Calls" })
          vim.keymap.set("n", "<leader>flo", builtin.lsp_outgoing_calls, { desc = "LSP Outgoing Calls" })
          vim.keymap.set("n", "<leader>fld", function()
            require("telescope.builtin").diagnostics({ bufnr = 0 })
          end, { desc = "Document Diagnostics" })
          vim.keymap.set("n", "<leader>flD", builtin.diagnostics, { desc = "Workspace Diagnostics" })
        end
      })
    end,
  },
}
