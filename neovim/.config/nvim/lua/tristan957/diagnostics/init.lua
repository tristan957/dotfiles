vim.keymap.set(
  "n",
  "|dq",
  vim.diagnostic.setqflist,
  { desc = "Send diagnostics to quickfix list" }
)

vim.keymap.set(
  "n",
  "|dl",
  vim.diagnostic.setloclist,
  { desc = "Send diagnostics to location list" }
)
