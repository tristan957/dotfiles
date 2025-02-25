local M = {}

local fs = require("tristan957.utils.fs")

--- fd(1) command which will return files in a project
---@param ignore_largely_irrelevant_paths boolean
---@return string[]
M.project_files = function(ignore_largely_irrelevant_paths)
  local cmd = {
    "fd",
    "--color=never",
    "--type=f",
    "--hidden",
    "--follow",
  }

  if not ignore_largely_irrelevant_paths then
    return cmd
  end

  vim.list_extend(
    cmd,
    vim
      .iter(fs.largely_irrelevant_paths)
      :map(function(p)
        return string.format("--exclude='%s'", p)
      end)
      :totable()
  )

  return cmd
end

return M
