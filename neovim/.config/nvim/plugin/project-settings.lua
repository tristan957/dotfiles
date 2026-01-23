---@class (exact) ProjectSettingsOpts
---@field fs_root string? Filesystem root to elide when path matches
---@field rtps_root string? Root of the various project runtimepaths
---@field overrides { [string]: string } Mapping from cwd pattern to runtimepath name

local opts = vim.g.project_settings_opts
  or {
    fs_root = nil,
    rtps_root = nil,
    overrides = {},
  } --[[@as ProjectSettingsOpts]]

opts.overrides = opts.overrides or {}

if opts.rtps_root == nil then
  return
end

local cwd = vim.env.PWD
local project = nil

-- Check for overrides first
for pattern, rtp_name in pairs(opts.overrides) do
  if string.find(cwd, pattern) then
    project = rtp_name
    break
  end
end

-- Fall back to automatic detection if no override matched
if project == nil then
  if opts.fs_root == nil then
    return
  end

  local _, e = string.find(cwd, opts.fs_root)
  if e == nil then
    return
  end

  -- +2 to move past last letter and trailing slash
  project = string.sub(cwd, e + 2)
end

vim.print(project)

local rtp = vim.fs.joinpath(opts.rtps_root, project)
if vim.fn.isdirectory(rtp) == 1 then
  -- Append the project's runtimepath
  vim.opt.runtimepath:append(rtp)
  package.path = package.path .. ";" .. rtp .. "/?.lua;" .. rtp .. "/?/init.lua;"

  -- Load the project.lua file if it exists
  pcall(require, "project")

  Snacks.notifier.notify("Loaded runtimepath", vim.log.levels.INFO, {
    icon = "󱁿",
    title = "Project Settings",
  })
end
