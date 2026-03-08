local fs = require("tristan957.utils.fs")

---@type string?
local current_bin = nil

---Update the PATH environment variable to include the node_modules/.bin
---directory
local function update_path()
  local path = vim.fn.getenv("PATH")

  if current_bin ~= nil then
    path = path:gsub(vim.pesc(current_bin .. ":"), "")
    current_bin = nil
  end

  local node_modules = fs.find_directory("node_modules")
  if node_modules ~= nil then
    current_bin = vim.fs.joinpath(node_modules, ".bin")
    path = string.format("%s:%s", current_bin, path)
  end

  vim.fn.setenv("PATH", path)
end

update_path()

vim.api.nvim_create_autocmd("DirChanged", {
  callback = update_path,
})
