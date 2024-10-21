local group = vim.api.nvim_create_augroup("tristan957_project", { clear = true })

-- We setup our own autocmd
vim.api.nvim_del_augroup_by_name("tristan957_lsp_format")

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
