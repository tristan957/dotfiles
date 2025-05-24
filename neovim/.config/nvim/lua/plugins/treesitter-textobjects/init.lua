---@module "lazy"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  enabled = true,
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufNewFile", "BufReadPre" },
}
