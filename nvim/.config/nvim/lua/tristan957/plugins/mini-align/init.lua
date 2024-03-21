---@type LazySpec
return {
  "echasnovski/mini.align",
  event = "VeryLazy",
  config = function()
    local align = require("mini.align")

    align.setup()
  end
}
