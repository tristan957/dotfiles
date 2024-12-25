---@module "blink.cmp"
---@module "lazy"

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
      list = {
        selection = function(ctx)
          if ctx.mode == "cmdline" then
            return "manual"
          end

          return "preselect"
        end,
      },
      menu = {
        border = "none",
      },
    },
    keymap = {
      preset = "default",
      cmdline = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
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
