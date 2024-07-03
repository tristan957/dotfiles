---@type LazySpec
return {
  "echasnovski/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local MiniDiff = require("mini.diff")

    MiniDiff.setup({
      view = {
        style = "sign",
      },
    })
  end
}
