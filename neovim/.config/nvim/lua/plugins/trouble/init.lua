---@type LazySpec
return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local trouble = require("trouble")

    trouble.setup({
      indent_guides = true,
      ---@type trouble.Window.opts
      win = {
        border = "rounded",
        position = "bottom",
      },
    })
  end,
}
