---@type LazySpec
return {
  "vhyrro/luarocks.nvim",
  lazy = true,
  config = function()
    local luarocks = require("luarocks")

    luarocks.setup({})
  end,
}
