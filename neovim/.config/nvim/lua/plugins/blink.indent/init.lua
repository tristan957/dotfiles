---@module "blink.indent"
---@module "lazy"

---@type LazySpec
return {
  "saghen/blink.indent",
  cond = true,
  enabled = true,
  event = "BufRead",
  --- @type blink.indent.Config
  opts = {
    scope = {
      char = "▎",
      enabled = true,
      highlights = require("tristan957.utils.list").shuffle({
        "BlinkIndentOrange",
        "BlinkIndentViolet",
        "BlinkIndentBlue",
        "BlinkIndentRed",
        "BlinkIndentCyan",
        "BlinkIndentYellow",
        "BlinkIndentGreen",
      }),
    },
    static = {
      char = "▏",
      enabled = true,
    },
    underline = {
      enabled = false,
    },
  },
}
