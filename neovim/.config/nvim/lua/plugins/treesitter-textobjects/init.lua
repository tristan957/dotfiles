---@module "lazy"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  enabled = true,
  branch = vim.fn.has("nvim-0.11") == 1 and "main" or "master",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufNewFile", "BufReadPre" },
}
