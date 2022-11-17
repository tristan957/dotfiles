vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  source = true,
  float = { border = "single" },
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>df",
  '<cmd>:lua vim.diagnostic.open_float(nil, {scope = "cursor"})<cr>',
  { noremap = true }
)
