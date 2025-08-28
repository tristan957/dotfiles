---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.ai",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
