---@type LazySpec[]
return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    event = "VeryLazy",
    config = function()
      local dapui = require("dapui")

      dapui.setup()
    end,
  },
}
