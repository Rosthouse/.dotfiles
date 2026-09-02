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

-- JSON
vim.lsp.enable('jsonls')

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
  root_markers = { '.git', '.slnx' },
  cmd = { 'roslyn-language-server', '--autoLoadProjects', '--daemon-mode', '--daemonKeepAlive', '300', '--sourceGeneratorExecutionPreference', 'Balanced', '--stdio' },
  root_dir = function(_, cb)
    cb(vim.fn.getcwd())
  end,
  on_init = {
    function(client)
      local root_dir = client.config.root_dir
      local solutions = vim.fs.find(function(name)
        return name:match('%.slnx?$') ~= nil
      end, { limit = math.huge, type = 'file', path = root_dir })

      local function open_sln(sln)
        client:notify('solution/open', { solution = vim.uri_from_fname(sln) })
        vim.cmd('compiler! dotnet')
      end

      if #solutions > 1 then
        vim.ui.select(solutions, { prompt = 'Select solution' }, function(sln)
          if sln then open_sln(sln) end
        end)
      elseif #solutions == 1 then
        open_sln(solutions[1])
      else
        -- no solution found, open projects
        local projects = {}
        for entry, type in vim.fs.dir(root_dir) do
          if type == 'file' and vim.endswith(entry, '.csproj') then
            table.insert(projects, vim.uri_from_fname(vim.fs.joinpath(root_dir, entry)))
          end
        end
        if #projects > 0 then
          client:notify('project/open', { projects = projects })
        end
      end
    end,
  },
})

vim.lsp.enable('roslyn_ls')

-- Taplo
vim.lsp.enable('taplo')

-- yaml
vim.lsp.enable('yamlls')


local lsp_group = 'my.lsp'
-- Autocommands
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup(lsp_group, {}),
  ---@param ev {data: vim.event.lspattach.data}
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

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
        group = vim.api.nvim_create_augroup(lsp_group, { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})


local lsp_actions = {
  {
    name = "Restart LSP",
    fn = function()
      for _, client in vim.lsp.get_clients() do
        client.stop()
      end
      vim.cmd.edit()
    end,
  },
  {
    name = "Toggle Codelens",
    fn = function()
      local buf = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = buf })
      for _, client in ipairs(clients) do
        if client:supports_method('textDocument/codeLens') then
          vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
        end
      end
    end,
  },
  {
    name = "Toggle Inlay Hints",
    fn = function()
      local buf = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = buf })
      for _, client in ipairs(clients) do
        if client:supports_method('textDocument/inlayHint') then
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end
      end
    end,
  },
  { name = "LSP checkhealth", fn = function() vim.cmd("checkhealth vim.lsp") end },
}

vim.keymap.set("n", "<leader>la", function()
  vim.ui.select(lsp_actions, {
    prompt = "Vim actions",
    path_display = { "truncate" },
    format_item = function(a) return a.name end,
  }, function(a)
    if a then a.fn() end
  end)
end, { desc = "LSP action menu" })
