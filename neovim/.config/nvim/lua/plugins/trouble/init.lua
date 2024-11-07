---@type LazySpec
return {
  "folke/trouble.nvim",
  event = { "BufReadPre", "BufNewFile" },
  ---@type trouble.Config
  opts = {
    indent_guides = true,
    win = {
      border = "rounded",
      position = "bottom",
    },
  },
}
