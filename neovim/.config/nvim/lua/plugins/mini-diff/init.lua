---@module "lazy"

---@type LazySpec
return {
  "echasnovski/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = "sign",
    },
  },
}
