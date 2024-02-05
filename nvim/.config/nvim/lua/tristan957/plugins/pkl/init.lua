---@type LazySpec
return {
  "apple/pkl-neovim",
  ft = "pkl",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    vim.cmd("TSInstall! pkl")
  end,
}
