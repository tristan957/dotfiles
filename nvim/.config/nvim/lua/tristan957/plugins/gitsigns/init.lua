---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({})

    vim.keymap.set("n", "]h", gitsigns.next_hunk)
    vim.keymap.set("n", "[h", gitsigns.previous_hunk)
    vim.keymap.set("n", "\\h", gitsigns.preview_hunk_inline)
  end,
}
