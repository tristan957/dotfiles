local M = {}

---Get the XDG_CONFIG_HOME path
---@return string
M.config_home = function()
  local dir = vim.uv.os_getenv("XDG_CONFIG_HOME")
  if dir ~= nil then
    return dir
  end

  return vim.fs.joinpath(vim.fn.getenv("HOME"), ".config")
end

return M
