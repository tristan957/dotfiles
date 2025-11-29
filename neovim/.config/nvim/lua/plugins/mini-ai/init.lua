---@module "lazy"
---@module "mini.ai"

---@type LazySpec
return {
  "nvim-mini/mini.ai",
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
