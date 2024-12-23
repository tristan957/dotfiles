---@module "blink.cmp"
---@module "lazy"

---@diagnostic disable: missing-fields

---@type LazySpec
return {
  "Saghen/blink.cmp",
  enabled = true,
  lazy = true,
  version = "v0.*",
  event = { "CmdlineEnter", "InsertEnter" },
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        border = "none",
      },
    },
    keymap = {
      preset = "default",
    },
    signature = {
      enabled = true,
    },
    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
