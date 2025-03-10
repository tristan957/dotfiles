---@module "lazy"
---@module "todo-comments"

---@type LazySpec
return {
  "folke/todo-comments.nvim",
  enabled = true,
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
