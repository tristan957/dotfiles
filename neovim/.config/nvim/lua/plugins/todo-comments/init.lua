---@type LazySpec
return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  ---@type TodoOptions
  opts = {
    keywords = {
      NEON = {
        color = "info",
      },
    },
  },
}
