---@type LazySpec
return {
  "echasnovski/mini.hipatterns",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local MiniHipatterns = require('mini.hipatterns')

    MiniHipatterns.setup({
      highlighters = {
        fixme = nil,
        hack = nil,
        todo = nil,
        note = nil,

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = MiniHipatterns.gen_highlighter.hex_color(),
      },
    })
  end
}
