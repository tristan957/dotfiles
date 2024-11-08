---@module "lazy"

---@type LazySpec
return {
  "Bekaboo/dropbar.nvim",
  event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
}
