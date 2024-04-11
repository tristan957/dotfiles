---@type LazySpec
return {
  "j-hui/fidget.nvim",
  event = "UIEnter",
  config = function()
    local fidget = require("fidget")

    fidget.setup({})
  end
}
