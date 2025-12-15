---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.install({
        "bash",
        "c",
        "c_sharp",
        "html",
        "ini",
        "json",
        "jsonc",
        "latex",
        "lua",
        "markdown",
        "python",
        "vim",
        "vimdoc",
        "xml",
      })

      local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
      local ignore_filetypes = {
        "checkhealth",
        "lazy",
        "mason",
      }


      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "Enable treesitter highlighting and indentation",
        callback = function(event)
          if vim.tbl_contains(ignore_filetypes, event.match) then
            return
          end


          local lang = vim.treesitter.language.get_lang(event.match) or event.match
          local buf = event.buf

          pcall(vim.treesitter.start, buf, lang)

          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          ts.install({ lang })
        end
      })
    end,
  },
}
