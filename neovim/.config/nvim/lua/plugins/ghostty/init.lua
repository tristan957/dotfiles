---@module "lazy"

---@type LazySpec
return {
  "bezhermoso/tree-sitter-ghostty",
  ft = "ghostty",
  build = "make nvim_install",
  cond = vim.fn.executable("make") == 1
}
