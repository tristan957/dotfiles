local M = {}

---Prompt for arguments and parse them using shlex-style splitting
---@return string[]
M.args = function()
  local co = coroutine.running()
  vim.ui.input({ prompt = "Arguments (space-separated): " }, function(input)
    vim.schedule(function()
      coroutine.resume(co, input)
    end)
  end)

  local input = coroutine.yield()
  return require("tristan957.utils.shlex").split(input or "")
end

---Prompt for executable name and pick a process
---@return number
M.pid = function()
  local co = coroutine.running()
  vim.ui.input({ prompt = "Executable name (filter): " }, function(name)
    vim.schedule(function()
      coroutine.resume(co, name)
    end)
  end)
  local name = coroutine.yield()
  return require("dap.utils").pick_process({ filter = name })
end

return M
