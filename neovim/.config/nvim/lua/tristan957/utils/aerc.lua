local M = {}

--- Check whether or not Neovim is a subprocess of aerc
---
---@return boolean
M.is_subprocess = function()
  return vim.env.AERC_ACCOUNT ~= nil
end

return M
