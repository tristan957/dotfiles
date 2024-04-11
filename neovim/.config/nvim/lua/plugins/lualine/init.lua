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
        icons_enabled = true,
        theme = "onedark_vivid",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_b = {
          "branch",
          "diff",
        },
        lualine_c = {
          "filename",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            always_visible = false,
            update_in_insert = true,
          },
        },
        lualine_x = {
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
    })
  end,
}
