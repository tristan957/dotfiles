local M = {}

M.augroup = vim.api.nvim_create_augroup("tristan957_treesitter", { clear = true })

--- Check if a tree-sitter parser is available for the filetype
---@param ft string
---@return boolean
M.has_parser = function(ft)
  local language = vim.treesitter.language.get_lang(ft) or ft
  local loaded, err = vim.treesitter.language.add(language)
  if err ~= nil then
    return false
  end

  assert(loaded ~= nil)

  return loaded
end

--- Check whether the tree-sitter CLI is available
---@return boolean
M.is_cli_available = function()
  return vim.fn.executable("tree-sitter") == 1
end

return M
