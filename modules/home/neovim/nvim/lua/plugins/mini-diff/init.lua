---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = "sign",
      signs = {
        add = "┃",
        change = "┃",
        delete = "┃",
      },
    },
  },
}
