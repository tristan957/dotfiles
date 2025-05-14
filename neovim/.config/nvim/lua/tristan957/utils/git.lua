local M = {}

--- Check whether or not Neovim is running as the GIT_EDITOR
---
---@return boolean
M.is_editor = function()
  return vim.env.GIT_EXEC_PATH ~= nil
end

return M
