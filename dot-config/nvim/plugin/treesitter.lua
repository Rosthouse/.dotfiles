vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  }
})

require('nvim-treesitter').install( { 'bash', 'c_sharp', 'lua', 'python' } )

-- {
--   "nvim-treesitter/nvim-treesitter",
--   branch = "main",
--   lazy = false,
--   build = ":TSUpdate",
--   config = function(self, opts)
--     local enabled_languages = {
--       'bash',
--       'c_sharp',
--       'python',
--       'xml',
--     }
--     require('nvim-treesitter').install(enabled_languages)
-- 
--     vim.api.nvim_create_autocmd('FileType', {
--       pattern = enabled_languages,
--       callback = function()
--         -- syntax highlighting, provided by Neovim
--         vim.treesitter.start()
-- 
--         if require("nvim-treesitter.parsers").has_parser() then
--             -- use treesitter folding
--             vim.opt.foldmethod = "expr"
--             vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--             -- indentation, provided by nvim-treesitter
--             vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--         else
--             -- use alternative foldmethod
--             vim.opt.foldmethod = "syntax"
--         end
--         -- disable folding on startup
--         vim.opt.foldenable = false
--       end,
--     })
--   end
-- },
