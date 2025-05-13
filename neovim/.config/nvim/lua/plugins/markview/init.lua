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
        on_attach = function(_, wins)
          vim.iter(wins):each(function(winid)
            vim.wo[winid].list = false
          end)
        end,
        on_detach = function(_, wins)
          vim.iter(wins):each(function(winid)
            vim.wo[winid].list = true
          end)
        end,
        on_mode_change = function(_, wins, mode)
          vim.iter(wins):each(function(winid)
            vim.wo[winid].list = mode == "i"
          end)
        end,
      },
      ignore_buftypes = {},
    },
  },
}
