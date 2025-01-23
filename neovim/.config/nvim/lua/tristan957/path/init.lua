local PATH = vim.fn.getenv("PATH")

local node_modules = require("tristan957.utils.fs").node_modules
if node_modules ~= nil then
  PATH = string.format("%s:%s", vim.fs.joinpath(node_modules, ".bin"), PATH)
  vim.fn.setenv("PATH", PATH)
end
