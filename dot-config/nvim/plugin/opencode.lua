vim.pack.add({
  { src = "https://github.com/nickjvandyke/opencode.nvim" },
})

--@type opencode.Opts
vim.g.opencode_opts = {

}

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<C-a>a", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<C-a>x", function() require("opencode").select() end, { desc = "Select OpenCode…" })
vim.keymap.set({ "n", "x" }, "<C-a>L", function() return require("opencode").operator("@this") end,
  { desc = "Send range to OpenCode", expr = true })
vim.keymap.set({ "n" }, "<C-a>l", function() return require("opencode").operator("@this") .. "_" end,
  { desc = "Send line to OpenCode", expr = true })
