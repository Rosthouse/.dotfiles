return ({
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  opts = {
    keymap = {
      preset    = "default",
      ["<Tab>"] = { "accept", "fallback" },
      ["<CR>"]  = { "accept", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" }
      }
    }
  },
  opts_extend = { "sources.default" },

})
