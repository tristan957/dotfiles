vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    ".clang-format",
    ".clang-tidy",
  },
  command = "set filetype=sh",
})
