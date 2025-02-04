---@module "lazy"
---@module "trouble"

---@type LazySpec
return {
  "folke/trouble.nvim",
  lazy = true,
  cmd = "Trouble",
  ---@type trouble.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    indent_guides = true,
    win = {
      border = "rounded",
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
