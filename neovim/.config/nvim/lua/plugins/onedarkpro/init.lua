---@type LazySpec
return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  -- dev = true,
  config = function()
    local onedarkpro = require("onedarkpro")

    onedarkpro.setup({
      caching = true,
      styles = {
        types = "NONE",
        methods = "NONE",
        numbers = "NONE",
        strings = "NONE",
        comments = "NONE",
        keywords = "NONE",
        constants = "NONE",
        functions = "NONE",
        operators = "NONE",
        variables = "NONE",
        parameters = "NONE",
        conditionals = "NONE",
        virtual_text = "NONE",
      },
      highlights = {
        ["@property.meson"] = { fg = "${white}" },
      },
      options = {
        cursorline = vim.opt.cursorline,
      },
    })

    vim.cmd.colorscheme("onedark_vivid")
  end,
}
