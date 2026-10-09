local M = {}

--- Find the best Python executable for this directory, without blocking.
---@param callback fun(python: string)
M.find = function(callback)
  local poetry = require("tristan957.utils.poetry")

  --We are already in the virtual environment, so skip the setup.
  if vim.env.VIRTUAL_ENV ~= nil then
    callback("python3")
    return
  end

  if
    not (
      poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1
    )
  then
    callback("python3")
    return
  end

  poetry.python_executable(function(python)
    callback(python or "python3")
  end)
end

M.executable = "python3"

M.find(function(python)
  M.executable = python
end)

-- We need to find the correct Python executable again if we change directories
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    M.find(function(python)
      M.executable = python
    end)
  end,
})

return M
