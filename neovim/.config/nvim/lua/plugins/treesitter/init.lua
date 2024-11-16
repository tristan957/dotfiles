---@module "lazy"
---@module "nvim-treesitter"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = { "BufReadPre", "BufNewFile" },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = "all",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "dockerfile" },
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
  },
  config = function(_, opts)
    local context = require("treesitter-context")

    require("nvim-treesitter.configs").setup(opts)

    context.setup({
      separator = "─",
      on_attach = function()
        return true
      end,
    })

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    vim.keymap.set("n", "<C-w>C", context.toggle, { desc = "Toggle context" })
    vim.keymap.set("n", "[C", function()
      context.go_to_context(vim.v.count1)
    end, { silent = true, desc = "Jump to context" })
  end,
}
