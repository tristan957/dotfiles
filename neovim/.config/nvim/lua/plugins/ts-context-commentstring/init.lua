---@module "lazy"

---@type LazySpec
return {
  "folke/ts-comments.nvim",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
}
