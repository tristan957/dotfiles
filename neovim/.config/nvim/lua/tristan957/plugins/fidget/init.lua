---@type LazySpec
return {
  "j-hui/fidget.nvim",
  config = function()
    local fidget = require("fidget")

    fidget.setup({})
  end
}
