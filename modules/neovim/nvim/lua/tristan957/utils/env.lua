local M = {}

---Prepend a path to the PATH environment variable
---@param path string
---@return string
M.prepend_to_path = function(path)
  local current_path = vim.fn.getenv("PATH")
  if current_path ~= nil then
    return string.format("%s:%s", path, current_path)
  end

  return path
end

return M
