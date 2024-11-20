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
  init = function()
    package.preload["nvim-web-devicons"] = function()
      local MiniIcons = require("mini.icons")
      -- needed since it will be false when loading and mini will fail
      package.loaded["nvim-web-devicons"] = {}
      MiniIcons.mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
