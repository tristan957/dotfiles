local M = {}

---Paths that can largely be ignored when searching the filesystem
M.largely_irrelevant_paths = {
  ".cache/clangd",
  ".clangd",
  ".DS_Store",
  ".git",
  ".hg",
  ".mypy_cache",
  ".nfs*",
  ".pytest_cache",
  ".ruff_cache",
  ".svn",
  ".zig-cache",
  "__pycache__",
  "CVS",
  "node_modules",
  "po",
  "target",
}

local node_modules = vim.fs.joinpath(vim.env.PWD, "node_modules")
if vim.fn.isdirectory(node_modules) == 1 then
  M.node_modules = node_modules
else
  M.node_modules = nil
end

return M
