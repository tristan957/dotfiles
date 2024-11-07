---@type LazySpec
return {
  "echasnovski/mini.icons",
  lazy = true,
  config = function()
    local MiniIcons = require("mini.icons")

    MiniIcons.setup({
      style = "glyph",
    })

    MiniIcons.tweak_lsp_kind("prepend")
  end,
}
