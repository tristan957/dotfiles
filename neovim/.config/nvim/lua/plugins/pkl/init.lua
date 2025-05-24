---@module "lazy"

---@type LazySpec
return {
  "apple/pkl-neovim",
  -- Needs to be updated to make use of the nvim-treesitter main branch
  enabled = false,
  ft = "pkl",
  build = function()
    require("pkl-neovim").init()
  end,
}
