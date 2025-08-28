---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.move",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
