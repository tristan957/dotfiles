local system = require("tristan957.utils.system")

local M = {}

M.DARK_THEME = "onedark_vivid"
M.LIGHT_THEME = "onelight"

--- Set the theme
---
---@param theme "light" | "dark"
local function set_theme(theme)
  vim.cmd.colorscheme(theme == "light" and M.LIGHT_THEME or M.DARK_THEME)
end

M.setup = function()
  set_theme(system.color_scheme())

  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = function(_)
      set_theme(vim.o.background)
    end,
  })
end

return M
