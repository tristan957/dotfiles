local M = {}

local fs = require("tristan957.utils.fs")

---rg(1) command which will return files in a project
---@param ignore_largely_irrelevant_paths boolean
---@return string[]
M.project_files = function(ignore_largely_irrelevant_paths)
  local cmd = {
    "rg",
    "--color=never",
    "--files",
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
        return string.format("--glob='%s'", p)
      end)
      :totable()
  )

  return cmd
end

--- rg(1) command which will take a grep expression
---@param ignore_largely_irrelevant_paths boolean
---@return string[]
M.grep = function(ignore_largely_irrelevant_paths)
  local cmd = {
    "rg",
    "--hidden",
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--max-columns=4096",
    "-e",
  }

  if ignore_largely_irrelevant_paths then
    vim.iter(fs.largely_irrelevant_paths):each(function(p)
      table.insert(cmd, 2, string.format("--glob='!%s'", p))
    end)
  end

  return cmd
end

return M
