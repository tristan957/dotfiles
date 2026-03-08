---@module "lazy"

---@type LazySpec
return {
  "barrettruth/diffs.nvim",
  event = "VeryLazy",
  config = function()
    vim.g.diffs = {
      extra_filetypes = { "diff" },
      integrations = {
        fugitive = true,
        neogit = false,
      },
    }
  end
}
