---@type LazySpec
return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local todo_comments = require("todo-comments")

    todo_comments.setup()
  end,
}
