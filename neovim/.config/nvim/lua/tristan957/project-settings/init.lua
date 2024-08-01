local M = {}

---@class Opts
---@field fs_root string?
---@field rtps_root string?
local default_opts = {
  fs_root = nil,
  rtps_root = nil,
}

---@param opts Opts
M.setup = function(opts)
  if opts.fs_root == nil or opts.rtps_root == nil then
    return
  end

  local cwd = vim.env.PWD
  local _, e = string.find(cwd, opts.fs_root)
  if e == nil then
    return
  end

  -- +2 to move past last letter and trailing slash
  local project = string.sub(cwd, e + 2)

  local rtp = vim.fs.joinpath(opts.rtps_root, project)
  if vim.fn.isdirectory(rtp) == 1 then
    vim.opt.runtimepath:append(rtp)
  end
end

return M
