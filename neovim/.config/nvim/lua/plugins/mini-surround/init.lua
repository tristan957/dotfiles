---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.surround",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  opts = {},
}
