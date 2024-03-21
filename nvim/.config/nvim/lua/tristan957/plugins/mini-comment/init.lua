---@type LazySpec
return {
  "echasnovski/mini.comment",
  event = "VeryLazy",
  config = function()
    local comment = require("mini.comment")

    comment.setup()
  end
}
