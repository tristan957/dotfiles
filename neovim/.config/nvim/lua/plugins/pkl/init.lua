---@module "lazy"

---@type LazySpec
return {
  "apple/pkl-neovim",
  enabled = true,
  ft = "pkl",
  build = function()
    require("pkl-neovim.internal").init()
  end,
}
