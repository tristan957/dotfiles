---@type LazySpec
return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  config = function()
    require("ts-comments").setup()
  end,
}
