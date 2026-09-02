vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
})

require("telescope").setup({
  defaults = {
    path_display = { "truncate" },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
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

require("telescope").load_extension("ui-select")

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

-- LSP
vim.keymap.set("n", "<leader>fl", ts_builtin.lsp_references, { desc = "find LSP references" })
vim.keymap.set("n", "<leader>fld", ts_builtin.lsp_document_symbols, { desc = "find LSP references in document" })
vim.keymap.set("n", "<leader>fls", ts_builtin.lsp_document_symbols, { desc = "find LSP references in workspace" })
vim.keymap.set("n", "<leader>flS", ts_builtin.lsp_workspace_symbols, { desc = "find LSP references in workspace" })
vim.keymap.set("n", "<leader>flW", ts_builtin.lsp_dynamic_workspace_symbols,
  { desc = "find LSP references in workspace" })


-- Disable autocomplete in telescope buffers
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("autocompletion-sanitizer", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" then vim.bo[ev.buf].autocomplete = false end
  end,
})
