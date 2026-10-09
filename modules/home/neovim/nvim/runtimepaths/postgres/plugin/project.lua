local group = vim.api.nvim_create_augroup("tristan957_project", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = { "*.c", "*.h" },
  callback = function(ev)
    local pgindent = vim.g.pgindent or "pgindent"
    local pg_bsd_indent = vim.g.pg_bsd_indent or "pg_bsd_indent"

    if vim.fn.executable(pgindent) == 0 then
      return
    end

    local cmd = vim
      .system({
        pgindent,
        "--indent=" .. pg_bsd_indent,
        "--typedefs=src/tools/pgindent/typedefs.list",
        vim.api.nvim_buf_get_name(ev.buf),
      })
      :wait()
    if cmd.code == 0 then
      vim.cmd.edit()
      return
    end

    vim.notify("Failed to run pgindent (" .. cmd.code .. "): " .. cmd.stderr, vim.log.levels.ERROR)
  end,
})
