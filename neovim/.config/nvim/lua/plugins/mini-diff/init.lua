---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.diff",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = "sign",
    },
  },
}
