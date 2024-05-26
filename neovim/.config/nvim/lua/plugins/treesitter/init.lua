---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local context = require("treesitter-context")

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

    context.setup({
      separator = "─",
      on_attach = function()
        return true
      end,
    })

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr"
    vim.wo.foldenable = false

    vim.keymap.set("n", "\\C", context.toggle, { desc = "Toggle context" })
    vim.keymap.set("n", "[C", function()
      context.go_to_context(vim.v.count1)
    end, { silent = true, desc = "Jump to context" })
  end,
}
