---@class (exact) ProjectSettingsOpts
---@field fs_root string? Filesystem root to elide when path matches
---@field rtps_root string? Root of the various project runtimepaths
---@field overrides? { [string]: string } Mapping from cwd pattern to runtimepath name

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

local cwd = vim.uv.cwd()
if cwd == nil then
  return
end

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

  local _, e = string.find(cwd, opts.fs_root, 1, true)
  if e == nil then
    return
  end

  -- +2 to move past last letter and trailing slash
  local relative = string.sub(cwd, e + 2)

  -- Walk up the relative path to find the first matching runtimepath directory.
  -- This handles worktree layouts like Projects/postgres/master where the
  -- runtimepath is named "postgres", not "postgres/master".
  local candidate = relative
  while candidate ~= "" do
    if vim.fn.isdirectory(vim.fs.joinpath(opts.rtps_root, candidate)) == 1 then
      project = candidate
      break
    end
    -- Strip the last path component
    local parent = vim.fs.dirname(candidate)
    if parent == candidate then
      break
    end
    candidate = parent
  end

  if project == nil then
    return
  end
end

local rtp = vim.fs.joinpath(opts.rtps_root, project)

-- Append the project's runtimepath
vim.opt.runtimepath:append(rtp)

Snacks.notifier.notify("Loaded runtimepath", vim.log.levels.INFO, {
  icon = "󱁿",
  title = "Project Settings",
})
