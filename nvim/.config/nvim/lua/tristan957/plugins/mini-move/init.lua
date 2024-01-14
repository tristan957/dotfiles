---@type LazySpec
return {
  'echasnovski/mini.move',
  event = "VeryLazy",
  config = function()
    require('mini.move').setup({})
  end
}
