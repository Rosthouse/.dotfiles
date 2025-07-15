
local builtin = require('telescope.builtin')
local nvimtree = require('nvim-tree.api')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })


-- nvim-tree
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "h", nvimtree.tree.close,        { desc = "Close" })
vim.keymap.set("n", "H", nvimtree.tree.collapse_all, { desc = "Collapse All" })
