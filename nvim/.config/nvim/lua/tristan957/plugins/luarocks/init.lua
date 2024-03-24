---@type LazySpec
return {
  "vhyrro/luarocks.nvim",
  lazy = true,
  config = function()
    local luarocks = require("luarocks-nvim")

    luarocks.setup({})
  end,
}
