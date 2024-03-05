---@type LazySpec
return {
  "stevearc/dressing.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  event = "UIEnter",
  config = function()
    local dressing = require("dressing")

    dressing.setup()
  end
}
