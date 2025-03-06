---@module "lazy"

---@type LazySpec
return {
  "olimorris/onedarkpro.nvim",
  enabled = true,
  dependencies = {
    "folke/snacks.nvim",
  },
  lazy = false,
  priority = 500,
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
      ["@property.meson"] = { fg = "${white}" },
    },
    options = {
      cursorline = vim.opt.cursorline,
    },
  },
  config = function(_, opts)
    local onedarkpro = require("onedarkpro")

    onedarkpro.setup(opts)

    local toggle = Snacks.toggle.new({
      name = "Light theme",
      get = function()
        return vim.g.colors_name == "onelight"
      end,
      set = function(state)
        if state then
          vim.cmd.colorscheme("onelight")
        else
          vim.cmd.colorscheme("onedark_vivid")
        end
      end,
    })

    toggle:set(vim.o.background == "light")

    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function(_)
        toggle:set(vim.v.option_new == "light")
      end,
    })
  end,
}
