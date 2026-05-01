---@module "dap"

---@type dap.Adapter
return {
  type = "executable",
  command = require("tristan957.utils.python").executable,
  args = { "-m", "debugpy.adapter" },
}
