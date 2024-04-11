---@type LazySpec
return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "vhyrro/luarocks.nvim",
  },
  ft = "http",
  config = function()
    local rest = require("rest-nvim")

    rest.setup()
  end,
}
