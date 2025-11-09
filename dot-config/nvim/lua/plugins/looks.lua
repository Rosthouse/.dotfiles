return ({
  {
    "rebelot/kanagawa.nvim"
  },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
        }
      }
    end
  },
})
