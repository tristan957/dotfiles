---@module "lazy"
---@module "mini.icons"

---@type LazySpec
return {
  "nvim-mini/mini.icons",
  enabled = true,
  lazy = true,
  opts = {
    style = "glyph",
  },
  config = function(_, opts)
    local MiniIcons = require("mini.icons")

    MiniIcons.setup(opts)

    MiniIcons.mock_nvim_web_devicons()
    MiniIcons.tweak_lsp_kind("prepend")
  end,
}
