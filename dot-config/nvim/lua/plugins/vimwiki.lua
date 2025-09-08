return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/Documents/notes',
        syntax = 'markdown',
        ext = '.md',
        index = 'Personal',
      },
      {
        path = '~/Documents/notes',
        syntax = 'markdown',
        ext = '.md',
        index = 'Personal',
      },
    }
  end,
  config = function()
    vim.api.nvim_create_autocmd({ "BufNewFile", nil },
      {
        pattern = { "*diary/*.md" },
        callback = function()
          vim.cmd(":silent 0r !~/.config/vimwiki/diary-template '%'")
        end
      }
    )
  end
}
