vim.opt_local.expandtab = false
vim.opt_local.formatoptions = "tcqjro"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end
})
