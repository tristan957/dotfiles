---@module "lazy"
---@module "todo-comments"

---@type LazySpec
return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  ---@type TodoOptions | {}
  opts = {
    signs = false,
    keywords = {
      NEON = {
        color = "info",
      },
    },
  },
}
