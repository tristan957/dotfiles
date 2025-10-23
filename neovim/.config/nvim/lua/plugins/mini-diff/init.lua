---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.diff",
  cond = true,
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = "sign",
    },
  },
}
