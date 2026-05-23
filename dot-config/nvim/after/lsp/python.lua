vim.lsp.config("pyright", {
  settings = {
    venvPath = ".venv",
    venv = "venv",
  }
})
vim.lsp.enable("pyright")
