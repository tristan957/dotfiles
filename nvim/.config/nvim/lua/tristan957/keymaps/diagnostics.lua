vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end, { silent = true, desc = "Open diagnostic in floating window" })

vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { silent = true, desc = "Go to previous diagnostic" }
)

vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { silent = true, desc = "Go to next diagnostic" }
)

vim.keymap.set(
  "n",
  "<space>q",
  vim.diagnostic.toqflist,
  { desc = "Send diagnostics to quickfix list" }
)
