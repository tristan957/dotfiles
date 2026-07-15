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
    args = {}, -- provide arguments if needed
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
    pid = function()
      local co = coroutine.running()
      vim.ui.input({ prompt = "Executable name (filter): " }, function(name)
        vim.schedule(function()
          coroutine.resume(co, name)
        end)
      end)
      local name = coroutine.yield()
      return require("dap.utils").pick_process({ filter = name })
    end,
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
