return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope find buffers" })
      vim.keymap.set("n", "<leader>ft", builtin.commands, { desc = "Telescope find commands" })

      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Telescope quickfix list" })
      vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Telescope jump list" })
      vim.keymap.set("n", "<leader>fli", builtin.lsp_references, { desc = "Telescope LSP References" })
      vim.keymap.set("n", "<leader>fli", builtin.lsp_incoming_calls, { desc = "Telescope LSP Incoming Calls" })
      vim.keymap.set("n", "<leader>fli", builtin.lsp_outgoing_calls, { desc = "Telescope LSP Outgoing Calls" })
    end,
  },
  {
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          file_ignore_patterns = { "%__virtual.$" },
        }
      })
      telescope.load_extension("vstask")

      vim.keymap.set("n", "<leader>ta", telescope.extensions.vstask.tasks, { desc = "List Tasks" })
      vim.keymap.set('n', '<leader>ti', telescope.extensions.vstask.inputs, { desc = "List Inputs" })

      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.jobs()<CR>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.clear_inputs()<CR>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.cleanup_completed_jobs()<CR>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.launch()<cr>
      --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.command()<cr>
    end,
  },
}
