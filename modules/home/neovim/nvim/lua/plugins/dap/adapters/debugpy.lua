---@module "dap"

---@type dap.AdapterFactory
return function(callback)
  require("tristan957.utils.python").find(function(python)
    callback({
      type = "executable",
      command = python,
      args = { "-m", "debugpy.adapter" },
    })
  end)
end
