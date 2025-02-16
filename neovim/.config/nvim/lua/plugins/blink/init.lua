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
        selection = {
          auto_insert = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          preselect = function(ctx)
            return ctx.mode ~= "cmdline"
              and not require("blink.cmp").snippet_active({ direction = 1 })
          end,
        },
      },
      menu = {
        border = "none",
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    cmdline = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
    },
    keymap = {
      preset = "default",
    },
    signature = {
      enabled = true,
    },
    sources = {
      default = function()
        local default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        }

        if vim.bo.buftype == "lua" then
          return { "lazydev", table.unpack(default) }
        end

        local success, node = pcall(vim.treesitter.get_node)
        if
          success
          and node
          and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
        then
          return { "path", "buffer" }
        end

        return default
      end,
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
