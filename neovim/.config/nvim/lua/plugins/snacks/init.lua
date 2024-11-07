---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = false,
    },
    debug = {
      enabled = true,
    },
    gitbrowse = {
      enabled = false,
    },
    notifier = {
      enabled = true,
      style = "fancy",
    },
    quickfile = {
      enabled = false,
    },
    statuscolumn = {
      enabled = true,
    },
    words = {
      enabled = false,
    }
  },
}
