local utils = require("tristan957.utils")

local M = {}

---Get the cache-dir setting from poetry.
---@return string?
M.cache_dir = function()
  local cmd = vim.system({"poetry", "config", "cache-dir"}):wait()
  if cmd.code ~= 0 then
    return nil
  end

  return utils.rstrip(cmd.stdout)
end

---Get the virtualenvs.path setting from poetry.
---@return string?
M.virtualenvs_path = function()
  local cmd = vim.system({"poetry", "config", "virtualenvs.path"}):wait()
  if cmd.code ~= 0 then
    return nil
  end

  return utils.rstrip(cmd.stdout)
end

---Get the Python executable from poetry.
---@return string?
M.python_executable = function()
  local cmd = vim
    .system({
      "poetry",
      "env",
      "info",
      "--executable",
    })
    :wait()
  if cmd.code ~= 0 then
    return nil
  end

  local path, _ = utils.rstrip(cmd.stdout)

  return path
end


return M
