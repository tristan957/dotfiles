---@module "lazy"
---@module "mini.move"

---@type LazySpec
return {
  "nvim-mini/mini.move",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
