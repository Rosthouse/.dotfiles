vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/pwntester/octo.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
  on_attach = function(_)
    local gitsigns = require('gitsigns')
    vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line({ full = true }) end, { desc = 'Git Blame', })
    vim.keymap.set('n', '<leader>gbl', gitsigns.toggle_current_line_blame, { desc = 'Git Blame', })
  end,
})

local octo = require("octo")
octo.setup({
  file_panel = {
    icons = function(name, _)
      return require("mini.icons").get("file", name)
    end
  }
})

local search_gh = function()
  require("octo.utils").create_base_search_command({ include_current_repo = true })
end

vim.keymap.set('n', '<leader>goi', "<CMD>Octo issue list<CR>", { desc = 'GH Issue List', })
vim.keymap.set('n', '<leader>gop', "<CMD>Octo pr list<CR>", { desc = 'GH PR List', })
vim.keymap.set('n', '<leader>god', "<CMD>Octo discussion list<CR>", { desc = 'GH Discusison List', })
vim.keymap.set('n', '<leader>gon', "<CMD>Octo notification list<CR>", { desc = 'GH Discusison List', })
vim.keymap.set('n', '<leader>gos', search_gh, { desc = 'GH Discusison List', })
