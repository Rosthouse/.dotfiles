return
{
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "personal",
            path = "~/Vaults/Personal",
          },
          {
            name = "work",
            path = "~/Vaults/Work",
          },
        },
      })
    end,
  },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/Documents/notes',
          syntax = 'markdown',
          ext = '.md',
          autotag = 1,
        },
        {
          path = '~/Documents/notes/personal',
          syntax = 'markdown',
          ext = '.md',
        },
        {
          path = '~/Documents/notes/work',
          syntax = 'markdown',
          ext = '.md',
        },
      }
    end,
    config = function()
      vim.g.vimwiki_markdown_link_ext = 1
      vim.g.taskwiki_markup_syntax = "markdown"
      vim.api.nvim_create_autocmd({ "BufNewFile", nil },
        {
          pattern = { "*diary/*.md" },
          callback = function()
            vim.cmd(":silent 0r !~/.config/vimwiki/diary-template '%'")
          end
        }
      )
    end
  } }
