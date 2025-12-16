vim.treesitter.query.add_predicate("is-mjmap-config?", function(_, _, bufnr, _, _)
  if type(bufnr) == "string" then
    return
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  return filename:match(".*config/mjmap/config%.scfg$") ~= nil
end, { force = true })
