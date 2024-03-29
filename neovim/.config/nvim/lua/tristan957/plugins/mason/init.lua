---@type LazySpec[]
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = "VimEnter",
    config = function()
      local mason = require("mason")

      mason.setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    enabled = true,
  },
}
