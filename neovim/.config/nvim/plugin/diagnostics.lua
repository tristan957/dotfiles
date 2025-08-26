vim.diagnostic.config({
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
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "󰋽",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
  severity_sort = true,
  underline = true,
  virtual_lines = {
    current_line = true,
  },
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
