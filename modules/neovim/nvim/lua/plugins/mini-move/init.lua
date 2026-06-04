---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.move",
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
