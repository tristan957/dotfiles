---@module "lazy"
---@module "mini.diff"

---@type LazySpec
return {
  "nvim-mini/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = "sign",
    },
  },
}
