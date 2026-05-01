vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
  if type(bufnr) == "string" then
    return
  end

  local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
  local _, _, ext, _ = string.find(fname, ".*%.(%a+)(%.%a+)")
  if ext ~= nil then
    metadata["injection.language"] = ext
  end
end, {})
