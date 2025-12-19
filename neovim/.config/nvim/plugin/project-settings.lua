---@class (exact) ProjectSettingsOpts
---@field fs_root string? Filesystem root to elide when patch matching
---@field rtps_root string? Root of the various project runtimepaths

local opts = vim.g.project_settings_opts or {
  fs_root = nil,
  rtps_root = nil,
} --[[@as ProjectSettingsOpts]]

if opts.fs_root == nil or opts.rtps_root == nil then
  return
end

local cwd = vim.env.PWD
local _, e = string.find(cwd, opts.fs_root)
if e == nil then
  return
end

--+2 to move past last letter and trailing slash
local project = string.sub(cwd, e + 2)

local rtp = vim.fs.joinpath(opts.rtps_root, project)
if vim.fn.isdirectory(rtp) == 1 then
  vim.opt.runtimepath:append(rtp)
  package.path = package.path .. ";" .. rtp .. "/?.lua;" .. rtp .. "/?/init.lua;"
  require("project")
  Snacks.notifier.notify("Loaded project settings", vim.log.levels.INFO, {
    icon = "󱁿",
    title = "Project Settings",
  })
end
