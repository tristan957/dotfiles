---@module "lazy"

---@type LazySpec
return {
  "Bekaboo/dropbar.nvim",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
}
