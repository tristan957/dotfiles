---@type LazySpec
return {
  "echasnovski/mini.comment",
  event = "VeryLazy",
  config = function()
    local MiniComment = require("mini.comment")

    MiniComment.setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring()
            or vim.bo.commentstring
        end,
      },
    })
  end,
}
