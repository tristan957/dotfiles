---@module "lazy"
---@module "nvim-treesitter"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  cond = vim.fn.executable("tree-sitter") == 1,
  branch = vim.fn.has("nvim-0.11") == 1 and "main" or "master",
  build = ":TSUpdate",
  dependencies = {
    {
      "bezhermoso/tree-sitter-ghostty",
      cond = vim.fn.executable("tree-sitter") == 1,
    },
  },
  ---@type TSConfig | {}
  opts = {},
  config = function(_, opts)
    local filetypes = require("tristan957.treesitter").get_filetypes()

    require("nvim-treesitter").setup(opts)
    require("nvim-treesitter").install(filetypes, {
      summary = false,
    } --[[@as InstallOptions]])

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      pattern = filetypes,
      callback = function(ev)
        vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        vim.treesitter.start(ev.buf)
      end,
    })
  end,
}
