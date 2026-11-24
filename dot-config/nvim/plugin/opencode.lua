vim.pack.add({
  { src = "https://github.com/nickjvandyke/opencode.nvim" },
})

--@type opencode.Opts
vim.g.opencode_opts = {

}

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<C-c>a", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<C-c>x", function() require("opencode").select() end, { desc = "Select OpenCode…" })
vim.keymap.set({ "n", "x" }, "<C-c>L", function() return require("opencode").operator("@this") end,
  { desc = "Send range to OpenCode", expr = true })
vim.keymap.set({ "n" }, "<C-c>l", function() return require("opencode").operator("@this") .. "_" end,
  { desc = "Send line to OpenCode", expr = true })
