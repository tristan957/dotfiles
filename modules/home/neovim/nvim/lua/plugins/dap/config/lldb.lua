---@module "dap"

---@type dap.Configuration[]
return {
  {
    name = "Launch (C/C++)",
    type = "lldb",
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
    type = "lldb",
    request = "attach",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    pid = require("plugins.dap.utils").pid,
    cwd = "${workspaceFolder}",
  },
}
