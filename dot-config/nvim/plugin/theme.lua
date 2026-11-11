vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = "catppuccin" }
})

require("catppuccin").setup(
  {
    transparent_background = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    integrations = {
      mini = true,
      indentscope_color = "",
    },
  }
)

vim.cmd.colorscheme 'catppuccin-nvim'
