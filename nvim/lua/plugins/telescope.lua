return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' }
  config = function()
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
  end
}
