---@module "lazy"
---@module "mason"

---@type LazySpec
return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  event = "VimEnter",
  ---@type MasonSettings
  opts = {
    log_level = vim.log.levels.OFF,
    ui = {
      border = "rounded",
    },
  },
}
