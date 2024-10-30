local M = {}

---@param func function
---@param ... func_params
M.vcountify = function(func, ...)
  for _ = 1, vim.v.count1 do
    func(...)
  end
end

---Strips trailing newlines in a string
---@param s string
---@return string
M.rstrip = function(s)
  local s, _ = string.gsub(s, "(\n)$", "")
  return s
end

return M
