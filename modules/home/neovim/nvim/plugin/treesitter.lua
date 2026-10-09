vim.treesitter.query.add_predicate("filename?", function(_, _, bufnr, predicate)
  if type(bufnr) == "string" then
    return
  end

  local filename = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
  return filename == predicate[2]
end, { force = true })

vim.treesitter.query.add_predicate("filename-lua-match?", function(_, _, bufnr, predicate)
  if type(bufnr) == "string" then
    return
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)
  return filename:match(predicate[2]) ~= nil
end, { force = true })
