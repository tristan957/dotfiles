---@type LazySpec
return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({})
  end,
}
