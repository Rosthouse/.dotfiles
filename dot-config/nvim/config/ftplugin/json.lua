-- JSON
-- Enable Highlighting
vim.treesitter.start()

-- Enable Folding
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

-- Enable indenting
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
