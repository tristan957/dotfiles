---@type LazySpec
return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  dev = false,
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
        ["@constant.builtin.lua"] = { fg = "${orange}" },
        ["@string.special.url"] = { fg = "${blue}", italic = false, underline = true },
        ["@keyword.operator.lua"] = { link = "@keyword.lua" },
        ["@lsp.typemod.variable.global.lua"] = { link = "@lsp.typemod.variable.defaultLibrary.lua" },
        ["@property.meson"] = { fg = "${white}" },
      },
      options = {
        cursorline = vim.opt.cursorline,
      },
    })

    vim.cmd.colorscheme("onedark_vivid")
  end,
}
