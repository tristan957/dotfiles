---@module "dap"

---@type dap.Adapter
return {
  type = "executable",
  command = "rust-gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}
