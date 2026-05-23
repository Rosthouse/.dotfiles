vim.lsp.config('roslyn_ls', {
    filetypes = { 'cs', 'razor' },
})

vim.lsp.enable('roslyn_ls')
