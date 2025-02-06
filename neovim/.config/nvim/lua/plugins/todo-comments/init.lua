---@module "lazy"
---@module "todo-comments"

---@type LazySpec
return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  ---@type TodoOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    signs = false,
    keywords = {
      NEON = {
        color = "info",
      },
    },
  },
}
