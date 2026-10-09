---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.ai",
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
