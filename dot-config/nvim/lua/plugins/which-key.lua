return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>-",
      function()
        local wk = require("which-key")
        wk.show({ global = false })
        wk.add({
          { "<leader>f", group = "find", icon = "" },
          { "<leader>d", group = "diagnostics", icon = " " },
          {
            "<leader>b",
            icon = "",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          { "<leader>l", group = "language", desc = " Language" },
          { "<leader>G", group = "git", desc = "󰊢 Git" },
          { "<leader>t", group = "task", desc = " Tasks" },
        })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
