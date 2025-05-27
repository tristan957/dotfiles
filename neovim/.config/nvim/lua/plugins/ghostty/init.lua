---@module "lazy"

---@type LazySpec
return {
  "bezhermoso/tree-sitter-ghostty",
  enabled = true,
  ft = "ghostty",
  build = "make nvim_install",
  cond = function()
    return vim.fn.executable("make") == 1
  end,
}
