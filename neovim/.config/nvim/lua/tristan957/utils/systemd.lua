local M = {}

---Options to pass to systemd-run(1). See systemd-run(1) for more details.
---@class SystemdRunOptions
---@field unit string?
---@field pty boolean?
---@field pipe boolean?
---@field description string?
---@field same_dir boolean?
---@field quiet boolean?
---@field user boolean?

---Wrap a command array in systemd-run(1)
---@param cmd string[]
---@param options SystemdRunOptions?
M.wrap_with_run = function(cmd, options)
  local wrapper = { "systemd-run" }
  local o = options or {}

  ---@type string?
  local unit = vim.tbl_get(o, "unit")
  if unit then
    table.insert(wrapper, "--unit")
    table.insert(wrapper, o.unit)
  end

  ---@type string?
  local description = vim.tbl_get(o, "description")
  if description then
    table.insert(wrapper, "--description")
    table.insert(wrapper, o.description)
  end

  ---@type boolean?
  local same_dir = vim.tbl_get(o, "same_dir")
  if same_dir then
    table.insert(wrapper, "--same-dir")
  end

  ---@type boolean?
  local quiet = vim.tbl_get(o, "quiet")
  if quiet then
    table.insert(wrapper, "--quiet")
  end

  ---@type boolean?
  local user = vim.tbl_get(o, "user")
  if user then
    table.insert(wrapper, "--user")
  end
  ---
  ---@type boolean?
  local pipe = vim.tbl_get(o, "pipe")
  if pipe then
    table.insert(wrapper, "--pipe")
  end

  ---@type boolean?
  local pty = vim.tbl_get(o, "pty")
  if pty then
    table.insert(wrapper, "--pty")
  end

  return vim.iter({ wrapper, "--", table.unpack(cmd) }):flatten():totable()
end

return M
