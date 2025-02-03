---@module "lazy"

---@type LazySpec
return {
  "apple/pkl-neovim",
  ft = "pkl",
  build = function()
    require("pkl-neovim.internal").init()
  end,
}
