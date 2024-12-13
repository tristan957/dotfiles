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

return M
