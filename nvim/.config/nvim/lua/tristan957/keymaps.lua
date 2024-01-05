vim.keymap.set("n", "<leader>df", function()
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end, { noremap = true, silent = true })

-- Similar to o or O without entering insert mode
vim.keymap.set("n", "oo", "o<Esc>")
vim.keymap.set("n", "OO", "O<Esc>")

vim.keymap.set("n", "Z", "<cmd>ZenMode<CR>")
vim.keymap.set("n", "<M-S-u>", "<cmd>nohl<CR>")
