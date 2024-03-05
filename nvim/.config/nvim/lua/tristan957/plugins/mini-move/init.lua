---@type LazySpec
return {
  'echasnovski/mini.move',
  event = "VimEnter",
  config = function()
    require('mini.move').setup({})
  end
}
