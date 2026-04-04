
  {
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
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
      vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
      vim.keymap.set("n", "<leader>tl", runLastTask, { desc = "Run Last" })
      vim.keymap.set("n", "<leader>tq", "<cmd>OverseerQuickAction<cr>", { desc = "Action recent task" })
      vim.keymap.set("n", "<leader>ti", "<cmd>OverseerInfo<cr>", { desc = "Overseer Info" })
      vim.keymap.set("n", "<leader>tb", "<cmd>OverseerBuild<cr>", { desc = "Task builder" })
      vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
      vim.keymap.set("n", "<leader>tc", "<cmd>OverseerClearCache<cr>", { desc = "Clear cache" })
    end
  }
