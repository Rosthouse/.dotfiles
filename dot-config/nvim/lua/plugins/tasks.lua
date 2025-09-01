return ({
  "EthanJWright/vs-tasks.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("vstask")

    vim.keymap.set("n", "<leader>ta", telescope.extensions.vstask.tasks, { desc = " List Tasks" })
    vim.keymap.set('n', '<leader>ti', telescope.extensions.vstask.inputs, { desc = " List Inputs" })

    --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.jobs()<CR>
    --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.clear_inputs()<CR>
    --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.cleanup_completed_jobs()<CR>
    --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.launch()<cr>
    --vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.command()<cr>
  end,
})
