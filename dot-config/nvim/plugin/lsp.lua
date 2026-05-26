vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

-- Enable Bash
vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' },
})
vim.lsp.enable("bashls")

-- LUA
vim.lsp.enable('lua_ls')

-- Prettier
vim.lsp.config('prettier', {
  filetypes = { 'md', 'js', 'ts' },
})
vim.lsp.enable('prettier')

-- Python
vim.lsp.config("pyright", {
  settings = {
    venvPath = ".venv",
    venv = "venv",
  }
})
vim.lsp.enable("pyright")

-- Roslyn
vim.lsp.config('roslyn_ls', {
  filetypes = { 'cs', 'razor' },
  root_markers = { '.git' },
  cmd = { 'roslyn-language-server', '--sourceGeneratorExecutionPreference', 'Balanced', '--stdio' },
})

vim.lsp.enable('roslyn_ls')

-- Taplo
vim.lsp.enable('taplo')

-- yaml
vim.lsp.enable('yamlls')


-- Autocommands
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    -- Enable codelens if avaiable
    if client:supports_method('textDocument/codeLens') then
      vim.lsp.codelens.enable(true)
      vim.keymap.set("n", "grc", vim.lsp.codelens.run, { desc = "Run codelens" })
    end

    if client:supports_method('textDocument/linkedEditingRange') then
      vim.lsp.linked_editing_range.enable(true)
    end

    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true)
    end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
