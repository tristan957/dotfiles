---@module "lazy"
---@module "mini.move"

---@type LazySpec
return {
  "nvim-mini/mini.move",
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
