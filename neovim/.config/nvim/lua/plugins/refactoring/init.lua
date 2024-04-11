---@type LazySpec
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufRead", "BufNewFile" },
  config = function()
    local refactoring = require("refactoring")

    refactoring.setup()
  end,
}
