---@module "dap"

---@type dap.Configuration[]
return {
  {
    name = "Launch (Rust)",
    type = "rust-gdb",
    request = "launch",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    args = require("plugins.dap.utils").args,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process (Rust)",
    type = "rust-gdb",
    request = "attach",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    pid = require("plugins.dap.utils").pid,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234 (Rust)",
    type = "rust-gdb",
    request = "attach",
    target = "localhost:1234",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    cwd = "${workspaceFolder}",
  },
}
