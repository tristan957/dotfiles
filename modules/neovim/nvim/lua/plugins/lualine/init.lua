---@module "lazy"
---@module "lualine"

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  opts = {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
    },
    sections = {
      lualine_b = {
        "branch",
        {
          "diff",
          source = function()
            local summary = vim.b.minidiff_summary
            if summary == nil then
              return nil
            end

            return {
              added = summary.add,
              modified = summary.change,
              removed = summary.delete,
            }
          end,
        },
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
        --{
        --  "%S",
        --  separator = "",
        --  draw_empty = true,
        --},
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
      require("plugins.lualine.extensions.snacks_dashboard"),
      "fugitive",
      "lazy",
      "man",
      "oil",
      "quickfix",
      "trouble",
    },
  },
}
