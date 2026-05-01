local M = {}

---@param func function
---@param ... any
M.vcountify = function(func, ...)
  for _ = 1, vim.v.count1 do
    func(...)
  end
end

---Strips trailing newlines in a string
---@param s string
---@return string
M.rstrip = function(s)
  local stripped, _ = string.gsub(s, "(\n)$", "")
  return stripped
end

---Prepend prefix to all element in a table
---@param prefix string
---@param tbl string[]
---@return string[]
M.prepend = function(prefix, tbl)
  local arr = {}
  for _, e in ipairs(tbl) do
    table.insert(arr, prefix .. e)
  end

  return arr
end

return M
