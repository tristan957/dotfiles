local M = {}

---Return the first path that exists, or nil if none exist
---@param paths string[]
---@return string|nil
function M.first_existing(paths)
  for _, path in ipairs(paths) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  return nil
end

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

---Find a directory by name relative to a base directory
---@param name string
---@param dir string?
---@return string?
M.find_directory = function(name, dir)
  local path = vim.fs.joinpath(dir or vim.env.PWD, name)
  if vim.fn.isdirectory(path) == 1 then
    return path
  end

  return nil
end

return M
