local M = {}

local utils = require("tristan957.utils")

---Get the cache-dir setting from poetry.
---@return string?
M.cache_dir = function()
  local cmd = vim.system({ "poetry", "config", "cache-dir" }):wait()
  if cmd.code ~= 0 then
    return nil
  end

  return utils.rstrip(cmd.stdout)
end

---Get the virtualenvs.path setting from poetry.
---@return string?
M.virtualenvs_path = function()
  local cmd = vim.system({ "poetry", "config", "virtualenvs.path" }):wait()
  if cmd.code ~= 0 then
    return nil
  end

  return utils.rstrip(cmd.stdout)
end

---Get the Python executable from poetry.
---
---If `callback` is omitted, this blocks until poetry responds. If `callback`
---is given, the command runs without blocking and `callback` is invoked with
---the result once it's ready.
---@param callback fun(python: string?)?
---@return string? python Only returned when `callback` is omitted.
M.python_executable = function(callback)
  local cmd_args = { "poetry", "env", "info", "--executable" }

  if callback == nil then
    local cmd = vim.system(cmd_args):wait()
    if cmd.code ~= 0 then
      return nil
    end

    return utils.rstrip(cmd.stdout)
  end

  vim.system(cmd_args, {}, function(cmd)
    vim.schedule(function()
      if cmd.code ~= 0 then
        callback(nil)
        return
      end

      callback(utils.rstrip(cmd.stdout))
    end)
  end)
end

---Is the directory a Poetry workspace?
---@param dir string
---@return boolean
M.is_workspace = function(dir)
  return vim.uv.fs_stat(vim.fs.joinpath(dir, "poetry.lock")) ~= nil
end

---Build a command line with `poetry run`.
---@param cmd string[]
---@return string[]
M.run_command_line = function(cmd)
  return {
    "poetry",
    "run",
    "--",
    unpack(cmd),
  }
end

---Run a command using `poetry run`.
---@param cmd string[]
---@return vim.SystemObj
M.run = function(cmd)
  return vim.system(M.run_command_line(cmd))
end

return M
