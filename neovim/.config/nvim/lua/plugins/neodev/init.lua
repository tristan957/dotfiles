---@type LazySpec
return {
  "folke/neodev.nvim",
  lazy = true,
  config = function()
    local neodev = require("neodev")

    neodev.setup({
      lspconfig = false,
    })
  end
}
