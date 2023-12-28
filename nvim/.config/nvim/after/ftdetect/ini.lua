vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "accounts.conf",
    "aerc.conf",
  },
  command = "set filetype=ini",
})
