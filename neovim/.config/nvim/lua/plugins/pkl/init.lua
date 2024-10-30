---@type LazySpec
return {
  "apple/pkl-neovim",
  lazy = true,
  ft = "pkl",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    require('pkl-neovim.internal').init()

    vim.cmd("TSInstall! pkl")
  end,
}
