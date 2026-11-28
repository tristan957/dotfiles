---@module "lazy"
---@module "onedarkpro"

---@type LazySpec
return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  dev = false,
  opts = {
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
      ["@property.meson"] = { link = "Text" },
      mailQuoted1 = { fg = "${cyan}" },
      mailQuoted2 = { fg = "${purple}" },
      mailQuoted3 = { fg = "${green}" },
      mailQuoted4 = { fg = "${yellow}" },
      mailQuoted5 = { fg = "${blue}" },
      mailQuoted6 = { fg = "${orange}" },
    },
    options = {
      cursorline = vim.o.cursorline,
    },
    plugins = {
      diffview = false,
    },
  },
}
