---@module "dap"

---@type dap.Configuration[]
return {
  {
    name = "Launch (C/C++)",
    type = "gdb",
    request = "launch",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    args = require("plugins.dap.utils").args,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process (C/C++)",
    type = "gdb",
    request = "attach",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    pid = require("plugins.dap.utils").pid,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234 (C/C++)",
    type = "gdb",
    request = "attach",
    target = "localhost:1234",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    cwd = "${workspaceFolder}",
  },
}
