---@module "blink.cmp"
---@module "lazy"

---@type LazySpec
return {
  "Saghen/blink.cmp",
  enabled = true,
  lazy = true,
  version = "v1.*",
  event = { "CmdlineEnter", "InsertEnter" },
  ---@type blink.cmp.Config
  opts = {
    completion = {
      list = {
        selection = {
          auto_insert = true,
          preselect = function(_)
            return not require("blink.cmp").snippet_active({ direction = 1 })
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
      completion = {
        ghost_text = {
          enabled = false,
        },
        list = {
          selection = {
            auto_insert = false,
            preselect = false,
          },
        },
        menu = {
          auto_show = true,
        },
      },
      enabled = true,
      keymap = {
        preset = "default",
        ["<Tab>"] = { "show", "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
    },
    keymap = {
      preset = "default",
    },
    signature = {
      enabled = false,
    },
    sources = {
      default = function()
        local default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        }

        local success, node = pcall(vim.treesitter.get_node)
        if
          success
          and node
          and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
        then
          return { "path", "buffer" }
        end

        if vim.bo.filetype == "lua" then
          return {
            "lazydev",
            unpack(default),
          }
        end

        return default
      end,
      -- For whatever reason, this does not work :^(
      -- per_filetype = {
      --   lua = { "lazydev" },
      -- },
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
