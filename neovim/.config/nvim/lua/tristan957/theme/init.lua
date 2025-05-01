local M = {}

M.DARK_THEME = "onedark_vivid"
M.LIGHT_THEME = "onelight"

M.setup = function()
  local toggle = Snacks.toggle.new({
    name = "Light theme",
    get = function()
      return vim.g.colors_name == "onelight"
    end,
    set = function(state)
      if state then
        vim.cmd.colorscheme(M.LIGHT_THEME)
      else
        vim.cmd.colorscheme(M.DARK_THEME)
      end
    end,
  })

  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = function(_)
      toggle:set(vim.v.option_new == "light")
    end,
  })
end

return M
