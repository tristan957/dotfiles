---@type LazySpec
return {
  "echasnovski/mini.align",
  event = "VeryLazy",
  config = function()
    local MiniAlign = require("mini.align")

    MiniAlign.setup()
  end
}
