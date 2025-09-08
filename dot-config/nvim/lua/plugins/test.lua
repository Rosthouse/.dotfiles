return ({
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-dotnet")({
            dap_settings = {
              type = "netcoredbg",
            }
          }),
        },
        custom_attributes = {
          nunit = { "UnitTest" },
        },
        output = { open_on_run = true },
      })

      require("which-key").add({
        { "<leader>lt", group = "󰙨 Test" },
      })

      vim.keymap.set('n', '<leader>ltr', neotest.run.run, { desc = 'Test' })
      vim.keymap.set('n', '<leader>ltR', function() neotest.run.run(vim.fn.expand("%")) end,
        { desc = 'Test File' })
      vim.keymap.set('n', '<leader>ltx', neotest.run.stop, { desc = ' Stop Running Tests' })
      vim.keymap.set('n', '<leader>ltd', function() neotest.run.run({ strategy = "dap" }) end,
        { desc = '  Debug Nearest Test' })
      vim.keymap.set('n', '<leader>ltd', function() neotest.run.run(vim.fn.expand("%"), { strategy = "dap" }) end,
        { desc = '  Debug Tests in File' })
      vim.keymap.set('n', '<leader>lto', function() neotest.output() end, { desc = 'Show Result for Test' })
      vim.keymap.set('n', '<leader>ltO', function() neotest.output() end, { desc = 'Show Result for File' })
      vim.keymap.set('n', '<leader>lts', neotest.summary.toggle, { desc = 'Show Test Summary' })
    end
  },
})
