return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          file_ignore_patterns = { "%__virtual.$" },
        }
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fh", function()
        require("telescope.builtin").find_files({ hidden = true })
      end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope find buffers" })
      vim.keymap.set("n", "<leader>ft", builtin.commands, { desc = "Telescope find commands" })

      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Telescope quickfix list" })
      vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Telescope jump list" })

      vim.keymap.set("n", "<leader>flr", builtin.lsp_references, { desc = "Telescope LSP References" })
      vim.keymap.set("n", "<leader>fli", builtin.lsp_incoming_calls, { desc = "Telescope LSP Incoming Calls" })
      vim.keymap.set("n", "<leader>flo", builtin.lsp_outgoing_calls, { desc = "Telescope LSP Outgoing Calls" })
    end,
  },
  {
    'stevearc/overseer.nvim',
    opts = {},
    config = function()
      local overseer = require("overseer")
      overseer.setup({
        dap = false
      })

      local function runLastTask()
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end

      vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Task list" })
      vim.keymap.set("n", "<leader>to", "<cmd>OverseerRun<cr>", { desc = "Run task" })
      vim.keymap.set("n", "<leader>tl", runLastTask, { desc = "Run Last" })
      vim.keymap.set("n", "<leader>tq", "<cmd>OverseerQuickAction<cr>", { desc = "Action recent task" })
      vim.keymap.set("n", "<leader>ti", "<cmd>OverseerInfo<cr>", { desc = "Overseer Info" })
      vim.keymap.set("n", "<leader>tb", "<cmd>OverseerBuild<cr>", { desc = "Task builder" })
      vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
      vim.keymap.set("n", "<leader>tc", "<cmd>OverseerClearCache<cr>", { desc = "Clear cache" })
    end
  }
}
