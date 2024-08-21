---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "onedarkpro.nvim",
  },
  event = "UIEnter",
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "auto",
      },
      sections = {
        lualine_b = {
          "branch",
          "diff",
        },
        lualine_c = {
          {
            "filename",
            path = 0,
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            always_visible = false,
            update_in_insert = true,
          },
        },
        lualine_x = {
          -- {
          --   "%S",
          --   separator = "",
          --   draw_empty = true,
          -- },
          "encoding",
          {
            "fileformat",
            icons_enabled = false,
          },
          {
            "filetype",
            icons_enabled = false,
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = {
        "fugitive",
        "lazy",
        "man",
        "mason",
        "oil",
        "quickfix",
        "trouble",
      },
    })
  end,
}
