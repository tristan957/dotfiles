---@module "lazy"
---@module "nvim-treesitter-textobjects"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  cond = require("tristan957.treesitter").is_cli_available() and vim.fn.has("nvim-0.11") == 1,
  enabled = true,
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufNewFile", "BufReadPre" },
  ---@type TSTextObjects.UserConfig
  opts = {
    select = {
      lookahead = true,
      selection_modes = {
        ["@class.outer"] = "<c-v>",
        ["@function.outer"] = "V",
        ["@parameter.outer"] = "v",
      },
      include_surrounding_whitespace = function(_)
        return false
      end,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    vim.keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@function.outer",
        "textobjects"
      )
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject(
        "@function.inner",
        "textobjects"
      )
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "as", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
    end)
  end,
}
