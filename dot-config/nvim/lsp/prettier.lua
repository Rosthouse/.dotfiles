

vim.api.nvim_create_autocmd({'BufSave',}, {
  pattern = { '*.md', },
  callback = function(ev)
    print('yayayaya')
  end
})
