---@type LazySpec
return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  config = function()
    local surround = require("mini.surround")

    surround.setup()
  end,
}
