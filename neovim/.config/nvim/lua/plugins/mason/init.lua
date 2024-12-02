---@module "lazy"
---@module "mason"

---@type LazySpec
return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  event = "VimEnter",
  ---@type MasonSettings
  opts = {
    ui = {
      border = "rounded",
    },
  },
}
