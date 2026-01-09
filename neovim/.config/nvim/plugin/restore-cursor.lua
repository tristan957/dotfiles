local ignored_filetypes = {
  "gitcommit",
  "gitrebase",
  "hgcommit",
  "snacks_picker_input",
  "svn",
}

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]

        if
          not vim.tbl_contains(ignored_filetypes, ft)
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"zz]], "nx", false)
        end
      end,
    })
  end,
})
