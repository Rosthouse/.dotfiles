vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

local treesitter = require("nvim-treesitter")

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
  "sql",
  "terraform",
})

vim.treesitter.language.register("bash", { "sh" })
vim.treesitter.language.register("c_sharp", { "cs", "razor" })
vim.treesitter.language.register("html", { "html", "razor" })
vim.treesitter.language.register("javascript", { "js", "razor" })
vim.treesitter.language.register("json", { "json", "jsonc", "avcl" })
vim.treesitter.language.register("lua", { "lua" })
vim.treesitter.language.register("nginx", { "conf" })
vim.treesitter.language.register("powershell", { "ps1" })
vim.treesitter.language.register("sql", { "sql" })
vim.treesitter.language.register("terraform", { "tf" })
