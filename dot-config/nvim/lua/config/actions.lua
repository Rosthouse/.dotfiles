local actions = {
  { name = "Update plugins",     fn = function() vim.pack.update() end },
  { name = "Show plugin status", fn = function() print(vim.inspect(vim.pack.get())) end },
  {
    name = "Set compiler (global)",
    fn = function()
      vim.ui.select(vim.fn.getcompletion("", "compiler"), { prompt = "Compiler" }, function(c)
        if c then vim.cmd("compiler! " .. c) end
      end)
    end,
  },
  {
    name = "Restart LSP",
    fn = function()
      vim.lsp.stop_client(vim.lsp.get_clients())
      vim.cmd.edit()
    end,
  },
  { name = "LSP checkhealth",    fn = function() vim.cmd("checkhealth vim.lsp") end },
  { name = "Toggle diagnostics", fn = function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end },
}

vim.keymap.set("n", "<leader>va", function()
  vim.ui.select(actions, {
    prompt = "Vim actions",
    format_item = function(a) return a.name end,
  }, function(a)
    if a then a.fn() end
  end)
end, { desc = "Vim action menu" })
