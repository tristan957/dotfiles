---@module "lazy"
---@module "onedarkpro"

---@type LazySpec
return {
  "olimorris/onedarkpro.nvim",
  enabled = true,
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
    },
    options = {
      cursorline = vim.o.cursorline,
    },
  },
}
