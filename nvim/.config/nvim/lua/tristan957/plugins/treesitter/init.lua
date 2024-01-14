---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr"
    vim.wo.foldenable = false
  end,
}
