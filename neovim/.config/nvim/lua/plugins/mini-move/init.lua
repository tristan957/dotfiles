---@type LazySpec
return {
  "echasnovski/mini.move",
  event = "VeryLazy",
  config = function()
    local MiniMove = require("mini.move")

    MiniMove.setup({})
  end,
}
