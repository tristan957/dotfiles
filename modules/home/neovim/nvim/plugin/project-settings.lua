---@class (exact) ProjectSettingsOpts
---@field runtimepaths { [string]: string } Mapping from cwd pattern to absolute runtimepath

local opts = vim.g.project_settings_opts --[[@as ProjectSettingsOpts?]]

if opts == nil or opts.runtimepaths == nil then
  return
end

local cwd = vim.uv.fs_realpath(vim.uv.cwd() or "")
if cwd == nil then
  return
end

local rtp = nil

for pattern, path in pairs(opts.runtimepaths) do
  if string.find(cwd, pattern, 1, true) then
    rtp = path
    break
  end
end

if rtp == nil then
  return
end

vim.opt.runtimepath:append(rtp)

Snacks.notifier.notify("Loaded runtimepath", vim.log.levels.INFO, {
  icon = "󱁿",
  title = "Project Settings",
})
