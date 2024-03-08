---@type LazySpec
return {
  "echasnovski/mini.comment",
  event = "BufEnter",
  config = function()
    local comment = require("mini.comment")

    comment.setup()
  end
}
