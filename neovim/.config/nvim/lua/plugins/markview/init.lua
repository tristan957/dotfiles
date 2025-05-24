---@module "lazy"
---@module "markview"

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  enabled = true,
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "Saghen/blink.cmp",
  },
  ---@type mkv.config
  opts = {
    preview = {
      filetypes = {
        "codecompanion",
        "markdown",
      },
      callbacks = {
        on_attach = function(_, _)
            vim.opt_local.list = false
        end,
        on_detach = function(_, _)
            vim.opt_local.list = true
        end,
        on_mode_change = function(_, _, mode)
            vim.opt_local.list = mode == "i"
        end,
      },
      ignore_buftypes = {},
    },
  },
}
