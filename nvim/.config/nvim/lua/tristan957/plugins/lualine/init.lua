require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "onedark_vivid",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
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
        symbols = { error = "E", warn = "W", info = "I", hint = "H" },
        always_visible = false,
        update_in_insert = true,
      },
    },
  },
})
