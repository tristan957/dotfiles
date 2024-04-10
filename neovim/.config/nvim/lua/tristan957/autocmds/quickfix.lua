local group = vim.api.nvim_create_augroup("tristan957/quickfix", { clear = true })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Automatically open quickfix window",
  group = group,
  pattern = "[^l]*",
  nested = true,
  callback = "cwindow",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Automatically open loclist window",
  group = group,
  pattern = "l*",
  nested = true,
  callback = "lwindow",
})
