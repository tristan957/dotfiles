---@module "lazy"
---@module "markview"

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  enabled = true,
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "Saghen/blink.cmp",
  },
  ---@type mkv.config
  opts = {
    preview = {
      filetypes = {
        "codecompanion",
        "markdown",
      },
      ignore_buftypes = {},
    },
  },
}
