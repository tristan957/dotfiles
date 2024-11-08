---@module "lazy"
---@module "trouble"

---@type LazySpec
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  ---@type trouble.Config
  opts = {
    indent_guides = true,
    win = {
      border = "rounded",
      position = "bottom",
    },
  },
}
