local M = {}

---Find the best Python executable for this directory
---@return string
M.find = function()
  local poetry = require("tristan957.utils.poetry")

  --We are already in the virual environment, so skip the setup.
  if vim.env.VIRTUAL_ENV ~= nil then
    return "python3"
  end

  if poetry.is_workspace(vim.uv.cwd() --[[@as string]]) then
    local python = poetry.python_executable()
    if python ~= nil then
      return python
    end
  end

  return "python3"
end

M.executable = M.find()

--We need to find the correct Python executable again if we change directories
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    M.executable = M.find()
  end,
})

return M
