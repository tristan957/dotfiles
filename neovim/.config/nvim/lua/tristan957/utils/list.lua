local M = {}

--- Shuffle a list in place
---@generic T
---@param list T[]
---@return T[]
M.shuffle = function(list)
  for i = #list, 2, -1 do
    local j = math.random(1, i)
    list[i], list[j] = list[j], list[i]
  end

  return list
end

return M
