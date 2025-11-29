---@module "lazy"
---@module "mini.align"

---@type LazySpec
return {
  "nvim-mini/mini.align",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
