return ({
  {
    'uZer/pywal16.nvim',
    -- for local dev replace with:
    -- dir = '~/your/path/pywal16.nvim',
    config = function()
      vim.cmd.colorscheme("pywal16")
    end,
  },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "uZer/pywal16.nvim" },
    opts = function()
      return {
        sections = {
          lualine_a = { 'branch' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              function(_)
                return "LSP ~ " .. vim.lsp.client.name:sub(5, -2)
              end,
              icons_enabled = true,
              icon = " ",
            }
          },
          lualine_z = {}
        },
        theme = "pywal16-nvim",
      }
    end
  },
})
