local M = {}

local utils = require("tristan957.utils")

--- Get the cache-dir setting from poetry.
---@return string?
M.cache_dir = function()
  local cmd = vim.system({ "poetry", "config", "cache-dir" }):wait()
  if cmd.code ~= 0 then
    return nil
  end

  return utils.rstrip(cmd.stdout)
end

--- Get the virtualenvs.path setting from poetry.
---@return string?
M.virtualenvs_path = function()
  local cmd = vim.system({ "poetry", "config", "virtualenvs.path" }):wait()
  if cmd.code ~= 0 then
    return nil
  end

  return utils.rstrip(cmd.stdout)
end

--- Get the Python executable from poetry.
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

  return utils.rstrip(cmd.stdout)
end

--- Is the directory a Poetry workspace?
---@param dir string
---@return boolean
M.is_workspace = function(dir)
  return vim.uv.fs_stat(vim.fs.joinpath(dir, "poetry.lock")) ~= nil
end

--- Run a synchronous command using `poetry run`.
---@param cmd string[]
---@return vim.SystemCompleted
M.run = function(cmd)
  return vim
    .system({
      "poetry",
      "run",
      "--",
      unpack(cmd),
    })
    :wait()
end

return M
