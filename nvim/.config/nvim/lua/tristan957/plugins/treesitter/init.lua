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

vim.g.skip_ts_context_commentstring_module = true

vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
]])
