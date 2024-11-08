---@module "lazy"

---@type LazySpec
return {
  "echasnovski/mini.icons",
  lazy = true,
  opts = {
    style = "glyph",
  },
  config = function(_, opts)
    local MiniIcons = require("mini.icons")

    MiniIcons.setup(opts)

    MiniIcons.tweak_lsp_kind("prepend")
  end,
}
