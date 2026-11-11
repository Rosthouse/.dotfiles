vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

local treesitter = require("nvim-treesitter")

vim.filetype.add({
  pattern = {
    ['*.razor'] = 'razor',
  },
})

treesitter.setup({
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
})

treesitter.install({
  "bash",
  "c_sharp",
  "html",
  "javascript",
  "json",
  "lua",
  "nginx",
  "powershell",
  "razor",
  "sql",
  "terraform",
})

vim.treesitter.language.register("bash", { "sh" })
vim.treesitter.language.register("c_sharp", { "cs" })
vim.treesitter.language.register("html", { "html" })
vim.treesitter.language.register("javascript", { "js" })
vim.treesitter.language.register("json", { "json", "jsonc", "avcl" })
vim.treesitter.language.register("lua", { "lua" })
vim.treesitter.language.register("nginx", { "conf" })
vim.treesitter.language.register("powershell", { "ps1" })
vim.treesitter.language.register("razor", { "razor", "cshtml" })
vim.treesitter.language.register("sql", { "sql" })
vim.treesitter.language.register("terraform", { "tf" })
