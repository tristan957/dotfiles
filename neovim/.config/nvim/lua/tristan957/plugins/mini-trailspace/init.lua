---@type LazySpec
return {
  "echasnovski/mini.trailspace",
  events = { "BufRead", "BufNewFile" },
  config = function()
    local MiniTrailspace = require("mini.trailspace")

    MiniTrailspace.setup()
  end,
}
