---@type LazySpec
return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local onedarkpro = require("onedarkpro")

    onedarkpro.setup({
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
    })

    vim.cmd("colorscheme onedark_vivid")
  end,
}
