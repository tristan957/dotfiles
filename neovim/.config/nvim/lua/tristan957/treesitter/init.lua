local M = {}

M.augroup = vim.api.nvim_create_augroup("tristan957_treesitter", { clear = true })

--- Check if a tree-sitter parser is available for the filetype
---@param ft string
---@return boolean
M.has_parser = function(ft)
  local language = vim.treesitter.language.get_lang(ft) or ft
  local success, _ = vim.treesitter.language.add(language)
  if success == nil then
    return false
  end

  return success
end

--- Check whether the tree-sitter CLI is available
---@return boolean
M.is_cli_available = function()
  return vim.fn.executable("tree-sitter") == 1
end

return M
