local M = {}

---@param func function
---@param ... func_params
M.vcountify = function(func, ...)
  for _ = 1, vim.v.count1 do
    func(...)
  end
end

return M
