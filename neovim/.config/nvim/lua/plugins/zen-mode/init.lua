---@module "lazy"

---@type LazySpec
return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "ZM", vim.cmd.ZenMode, "n", desc = "Toggle zen mode" },
  },
}
