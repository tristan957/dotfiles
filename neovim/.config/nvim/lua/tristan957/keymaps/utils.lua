local M = {}

---@param func function
---@param ... func_params
M.vcountify = function(func, ...)
  for _ = 1, vim.v.count == 0 and 1 or vim.v.count do
    func(...)
  end
end

return M
