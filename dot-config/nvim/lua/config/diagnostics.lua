local sev = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [sev.ERROR] = 'E',
      [sev.WARN]  = 'W',
      [sev.INFO]  = 'I',
      [sev.HINT]  = 'H',
    },
  },
})
