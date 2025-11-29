---@module "lazy"
---@module "ts-comments"

---@type LazySpec
return {
  "folke/ts-comments.nvim",
  enabled = true,
  event = { "BufNewFile", "BufReadPre" },
  ---@type TSCommentsOptions
  opts = {
    lang = {
      ini = "# %s",
    },
  },
}
