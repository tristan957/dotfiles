---@module "lazy"
---@module "trouble"

---@type LazySpec
return {
  "folke/trouble.nvim",
  lazy = true,
  cmd = "Trouble",
  ---@type trouble.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    indent_guides = true,
    win = {
      border = "rounded",
      position = "bottom",
    },
  },
}
