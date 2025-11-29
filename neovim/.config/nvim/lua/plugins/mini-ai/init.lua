---@module "lazy"
---@module "mini.ai"

---@type LazySpec
return {
  "nvim-mini/mini.ai",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
