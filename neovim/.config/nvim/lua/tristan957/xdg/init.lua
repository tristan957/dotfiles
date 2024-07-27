local M = {}

local HOME = vim.uv.os_homedir()
local XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or vim.fs.joinpath(HOME, ".config")
local XDG_DATA_HOME = os.getenv("XDG_DATA_HOME") or vim.fs.joinpath(HOME, ".local", "share")

---@return string
function M.config_home()
  return XDG_CONFIG_HOME
end

---@return string
function M.data_home()
  return XDG_DATA_HOME
end

return M
