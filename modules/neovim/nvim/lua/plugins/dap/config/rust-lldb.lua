---@module "dap"

-- Replicates what the `rust-lldb` wrapper script (shipped by rustup) does:
-- it runs `lldb` with `--one-line-before-file` and `--source-before-file` to
-- load the Rust pretty-printers before the target is set up. `lldb-dap`
-- doesn't shell out to `lldb`/`rust-lldb` at all, so we can't just point it
-- at the wrapper; instead we replicate its two commands via `initCommands`,
-- which `lldb-dap` runs at the same point in the session lifecycle.
---@return string[]
local function rust_init_commands()
  local result = vim.system({ "rustc", "--print", "sysroot" }):wait()
  if result.code ~= 0 then
    return {}
  end

  local sysroot = vim.trim(result.stdout or "")
  if sysroot == "" then
    return {}
  end

  return {
    ('command script import "%s/lib/rustlib/etc/lldb_lookup.py"'):format(sysroot),
    ('command source "%s/lib/rustlib/etc/lldb_commands"'):format(sysroot),
  }
end

---@type dap.Configuration[]
return {
  {
    name = "Launch (Rust)",
    type = "lldb",
    request = "launch",
    program = function()
      return require("dap.utils").pick_file({ executables = true })
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    initCommands = rust_init_commands,
  },
  {
    name = "Select and attach to process (Rust)",
    type = "lldb",
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
    initCommands = rust_init_commands,
  },
}
