local group = vim.api.nvim_create_augroup("tristan957_project", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  desc = "Format files on save",
  pattern = { "*.py", "*.rs" },
  callback = function(ev)
    vim.lsp.buf.format({
      bufnr = ev.buf,
      async = false,
    })
  end,
})
