vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "hse.conf",
    "kvdb.conf",
    "kvdb.meta",
    "kvdb.pid",
  },
  command = "set filetype=json",
})
