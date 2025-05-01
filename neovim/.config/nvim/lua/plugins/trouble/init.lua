---@module "lazy"
---@module "trouble"

---@type LazySpec
return {
  "folke/trouble.nvim",
  enabled = true,
  lazy = true,
  cmd = "Trouble",
  ---@type trouble.Config | {}
  opts = {
    indent_guides = true,
    win = {
      border = vim.o.winborder,
      position = "bottom",
    },
  },
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
}
