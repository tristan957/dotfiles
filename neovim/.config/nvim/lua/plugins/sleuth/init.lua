---@module "lazy"

---@type LazySpec
return {
  "tpope/vim-sleuth",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
}
