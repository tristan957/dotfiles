---@module "lazy"

---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  cond = vim.fn.has("nvim-0.11") == 1,
  event = "FileType",
}
