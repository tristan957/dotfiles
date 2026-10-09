local DARK_THEME = "onedark_vivid"
local LIGHT_THEME = "onelight"

---Set the theme
---
---@param theme "light" | "dark"
local function set_theme(theme)
  vim.cmd.colorscheme(theme == "light" and LIGHT_THEME or DARK_THEME)
end

set_theme(vim.o.background)

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function(_)
    set_theme(vim.o.background)
  end,
})
