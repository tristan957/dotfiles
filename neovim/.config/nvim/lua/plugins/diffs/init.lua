---@module "lazy"

---@type LazySpec
return {
  "barrettruth/diffs.nvim",
  event = "VeryLazy",
  config = function()
    vim.g.diffs = {
      fugitive = true,
      neogit = true,
      extra_filetypes = { "diff" },
    }
  end
}
