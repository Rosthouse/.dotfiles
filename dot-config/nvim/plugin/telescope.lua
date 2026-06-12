vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
})

require("telescope").setup({
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-x>"] = "delete_buffer",
        },
      }
    },
  },
})

local ts_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", ts_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fh", function()
  ts_builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "Telescope find hidden files" })

vim.keymap.set("n", "<leader>fb", ts_builtin.buffers, { desc = "find buffers" })
vim.keymap.set("n", "<leader>fg", ts_builtin.live_grep, { desc = "find buffers" })
vim.keymap.set("n", "<leader>ft", ts_builtin.commands, { desc = "find commands" })
vim.keymap.set("n", "<leader>fd", ts_builtin.diagnostics, { desc = "find diagnostics" })

vim.keymap.set("n", "<leader>fq", ts_builtin.quickfix, { desc = "quickfix list" })
vim.keymap.set("n", "<leader>fj", ts_builtin.jumplist, { desc = "jump list" })

-- Disable autocomplete in telescope buffers
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("autocompletion-sanitizer", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" then vim.bo[ev.buf].autocomplete = false end
  end,
})
