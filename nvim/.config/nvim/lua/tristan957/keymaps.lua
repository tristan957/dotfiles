vim.api.nvim_set_keymap(
  "n",
  "<leader>df",
  '<cmd>:lua vim.diagnostic.open_float(nil, {scope = "cursor"})<cr>',
  { noremap = true }
)

-- Similar to o or O without entering insert mode
vim.api.nvim_set_keymap("n", "oo", "o<Esc>", {})
vim.api.nvim_set_keymap("n", "OO", "O<Esc>", {})
