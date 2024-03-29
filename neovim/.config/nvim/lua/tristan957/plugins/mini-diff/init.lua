---@type LazySpec
return {
  "echasnovski/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini_diff = require("mini.diff")

    mini_diff.setup({
      view = {
        style = "sign",
      },
    })
  end
}
