vim.api.nvim_set_keymap(
  "n",
  "<leader>df",
  '<cmd>:lua vim.diagnostic.open_float(nil, {scope = "cursor"})<cr>',
  { noremap = true }
)
