---@module "lazy"

---@type LazySpec
return {
  "bezhermoso/tree-sitter-ghostty",
  ft = "ghostty",
  build = "make nvim_install",
  cond = require("tristan957.treesitter").is_cli_available() and vim.fn.executable("make") == 1,
}
