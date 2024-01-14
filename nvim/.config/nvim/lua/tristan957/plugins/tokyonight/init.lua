---@type LazySpec
return {
  "folke/tokyonight.nvim",
  lazy = true,
  config = function()
    local tokyonight = require("tokyonight")

    tokyonight.setup({})
  end,
}
