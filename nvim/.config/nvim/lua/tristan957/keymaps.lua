vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Similar to o or O without entering insert mode
vim.keymap.set("n", "oo", "o<Esc>")
vim.keymap.set("n", "OO", "O<Esc>")

vim.keymap.set("n", "Z", "<cmd>ZenMode<CR>")
vim.keymap.set("n", "<M-S-u>", "<cmd>nohl<CR>")
