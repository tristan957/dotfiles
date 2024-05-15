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
    local go = require("go")

    go.setup()

    local group = vim.api.nvim_create_augroup("tristan957_go", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
      end
    })
  end,
}
