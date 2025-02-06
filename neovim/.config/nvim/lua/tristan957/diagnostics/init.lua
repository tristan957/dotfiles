vim.diagnostic.config({
  float = {
    border = "solid",
  },
  -- Instead of using the sign column for diagnostic information, highlight the
  -- line numbers.
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
    text = {
      -- [vim.diagnostic.severity.ERROR] = "E",
      -- [vim.diagnostic.severity.WARN] = "W",
      -- [vim.diagnostic.severity.INFO] = "I",
      -- [vim.diagnostic.severity.HINT] = "H",
    },
  },
  severity_sort = true,
  virtual_text = true,
})

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
