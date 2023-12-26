vim.keymap.set(
  "n",
  "<leader>df",
  '<cmd>:lua vim.diagnostic.open_float(nil, {scope = "cursor"})<cr>',
  { noremap = true }
)

-- Similar to o or O without entering insert mode
vim.keymap.set("n", "oo", "o<Esc>")
vim.keymap.set("n", "OO", "O<Esc>")
