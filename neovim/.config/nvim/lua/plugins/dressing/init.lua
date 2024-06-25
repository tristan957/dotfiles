---@type LazySpec
return {
  "stevearc/dressing.nvim",
  event = "UIEnter",
  config = function()
    local dressing = require("dressing")

    dressing.setup()
  end
}
