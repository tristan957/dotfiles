---@module "lazy"
---@module "mason"

---@type LazySpec[]
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = "VimEnter",
    ---@type MasonSettings
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    enabled = true,
  },
}
