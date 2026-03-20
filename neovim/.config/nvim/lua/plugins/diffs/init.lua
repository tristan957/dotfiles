---@module "lazy"

---@type LazySpec
return {
  "barrettruth/diffs.nvim",
  init = function()
    vim.g.diffs = {
      extra_filetypes = { "diff" },
      integrations = {
        gitsigns = false,
        fugitive = true,
        neogit = false,
      },
    }
  end,
}
