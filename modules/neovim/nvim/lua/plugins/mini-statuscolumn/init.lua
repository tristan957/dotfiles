---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.statuscolumn",
  event = { "BufNewFile", "BufReadPre" },
  opts = {
    dim_inactive = false,
  },
}
