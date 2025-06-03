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
          for win in ipairs(wins) do
            vim.wo[win].list = false
          end
        end,
        on_detach = function(_, wins)
          for win in ipairs(wins) do
            vim.wo[win].list = true
          end
        end,
        on_mode_change = function(_, wins, mode)
          local list = mode == "i"
          for win in ipairs(wins) do
            vim.wo[win].list = list
          end
        end,
      },
      ignore_buftypes = {},
    },
  },
}
