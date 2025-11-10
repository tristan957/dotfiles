---@module "blink.indent"
---@module "lazy"

---@type LazySpec
return {
  "saghen/blink.indent",
  cond = true,
  enabled = true,
  event = "BufRead",
  opts = function()
    local colors = require("tristan957.utils.list").shuffle({
      "Orange",
      "Violet",
      "Blue",
      "Red",
      "Cyan",
      "Yellow",
      "Green",
    })

    --- @type blink.indent.Config
    return {
      scope = {
        char = "▎",
        enabled = true,
        highlights = vim
          .iter(colors)
          :map(function(c)
            return "BlinkIndent" .. c
          end)
          :totable(),
        underline = {
          enabled = true,
          highlights = vim
            .iter(colors)
            :map(function(c)
              return string.format("BlinkIndent%sUnderline", c)
            end)
            :totable(),
        },
      },
      static = {
        char = "▏",
        enabled = true,
      },
    }
  end,
}
