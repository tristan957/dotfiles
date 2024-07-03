---@type LazySpec
return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  config = function()
    local MiniSurround = require("mini.surround")

    MiniSurround.setup()
  end,
}
