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

---Get the XDG_DATA_HOME path
---@return string
M.data_home = function()
  local dir = vim.uv.os_getenv("XDG_DATA_HOME")
  if dir ~= nil then
    return dir
  end

  return vim.fs.joinpath(vim.fn.getenv("HOME"), ".local", "share")
end

return M
