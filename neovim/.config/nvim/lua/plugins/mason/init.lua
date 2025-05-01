---@module "lazy"
---@module "mason"

---@type LazySpec
return {
  "williamboman/mason.nvim",
  enabled = true,
  build = ":MasonUpdate",
  event = "VimEnter",
  ---@type MasonSettings
  opts = {
    log_level = vim.log.levels.OFF,
    ui = {
      border = vim.o.winborder,
    },
  },
}
