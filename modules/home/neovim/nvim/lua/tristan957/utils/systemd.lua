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
M.run_command_line = function(cmd, options)
  local wrapper = { "systemd-run" }
  local o = options or {}

  if o.unit then
    table.insert(wrapper, "--unit")
    table.insert(wrapper, o.unit)
  end

  if o.description then
    table.insert(wrapper, "--description")
    table.insert(wrapper, o.description)
  end

  if o.same_dir then
    table.insert(wrapper, "--same-dir")
  end

  if o.quiet then
    table.insert(wrapper, "--quiet")
  end

  if o.user then
    table.insert(wrapper, "--user")
  end

  if o.pipe then
    table.insert(wrapper, "--pipe")
  end

  if o.pty then
    table.insert(wrapper, "--pty")
  end

  return vim.iter({ wrapper, "--", unpack(cmd) }):flatten():totable()
end

return M
