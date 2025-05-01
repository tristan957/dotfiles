---@module "lazy"
---@module "markview"

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  enabled = true,
  lazy = true,
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-treesitter/nvim-treesitter",
    "Saghen/blink.cmp",
  },
  cmd = "Markview",
  ---@type mkv.config
  opts = {},
}
