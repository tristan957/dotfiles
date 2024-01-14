---@type LazySpec
return {
  "folke/neodev.nvim",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  lazy = true,
  config = function()
    local neodev = require("neodev")

    neodev.setup({
      library = {
        plugins = {
          "nvim-dap-ui",
          types = true,
        },
      },
    })
  end,
}
