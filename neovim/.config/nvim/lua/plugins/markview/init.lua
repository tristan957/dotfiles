---@module "lazy"
---@module "markview"

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "Saghen/blink.cmp",
  },
  ---@param _ LazyPlugin
  ---@param opts markview.config
  opts = function(_, opts)
    local filetypes = { "markdown" }
    if vim.tbl_get(opts, "preview", "filetypes") ~= nil then
      filetypes = vim.list_extend(filetypes, opts.preview.filetypes)
    end

    ---@type markview.config
    return vim.tbl_deep_extend("keep", {
      preview = {
        filetypes = filetypes,
        icon_provider = "mini",
        ignore_buftypes = {},
      },
    }, opts)
  end,
  ---@param _ LazyPlugin
  ---@param opts markview.config
  config = function(_, opts)
    require("markview").setup(opts)
    require("markview.extras.checkboxes").setup()
    require("markview.extras.editor").setup()
    require("markview.extras.headings").setup()
  end
}
