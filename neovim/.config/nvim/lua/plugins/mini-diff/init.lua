---@module "lazy"

---@type LazySpec
return {
  "echasnovski/mini.diff",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = "sign",
    },
  },
}
