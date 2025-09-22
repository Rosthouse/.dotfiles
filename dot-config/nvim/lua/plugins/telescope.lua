return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fh", function()
        require("telescope.builtin").find_files({ hidden = true })
      end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope find buffers" })
      vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope find buffers" })
      vim.keymap.set("n", "<leader>ft", telescope.commands, { desc = "Telescope find commands" })

      vim.keymap.set("n", "<leader>fq", telescope.quickfix, { desc = "Telescope quickfix list" })
      vim.keymap.set("n", "<leader>fj", telescope.jumplist, { desc = "Telescope jump list" })

      vim.keymap.set("n", "<leader>flr", telescope.lsp_references, { desc = "Telescope LSP References" })
      vim.keymap.set("n", "<leader>fli", telescope.lsp_incoming_calls, { desc = "Telescope LSP Incoming Calls" })
      vim.keymap.set("n", "<leader>flo", telescope.lsp_outgoing_calls, { desc = "Telescope LSP Outgoing Calls" })
    end,
  },
  {
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      { "Joakker/lua-json5", install = "./install.sh" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("vstask")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          file_ignore_patterns = { "%__virtual.$" },
        }
      })
      require("vstask").setup({
        json_parser = require("json5").parse
      })

      vim.keymap.set("n", "<leader>tt", telescope.extensions.vstask.tasks, { desc = "Tasks" })
      vim.keymap.set("n", "<leader>tl", telescope.extensions.vstask.launch, { desc = "Launch" })
      vim.keymap.set('n', '<leader>ti', telescope.extensions.vstask.inputs, { desc = "Inputs" })
      vim.keymap.set('n', '<leader>tj', telescope.extensions.vstask.jobs, { desc = "Jobs" })
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.clear_inputs()<CR>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.cleanup_completed_jobs()<CR>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.launch()<cr>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.command()<cr>
    end,
  },
}
