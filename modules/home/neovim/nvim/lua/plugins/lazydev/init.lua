---@module "lazy"
---@module "lazydev"

---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  ---@type lazydev.Config
  opts = {
    library = {
      { path = "mini.ai", words = { "MiniAi" } },
      { path = "mini.align", words = { "MiniAlign" } },
      { path = "mini.bracketed", words = { "MiniBracketed" } },
      { path = "mini.diff", words = { "MiniDiff" } },
      { path = "mini.icons", words = { "MiniIcons" } },
      { path = "mini.move", words = { "MiniMove" } },
      { path = "mini.surround", words = { "MiniSurround" } },
      { path = "mini.trailspace", words = { "MiniTrailspace" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
