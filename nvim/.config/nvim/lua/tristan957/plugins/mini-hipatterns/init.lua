---@type LazySpec
return {
  "echasnovski/mini.hipatterns",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini_hipatterns = require('mini.hipatterns')

    mini_hipatterns.setup({
      highlighters = {
        fixme = nil,
        hack = nil,
        todo = nil,
        note = nil,

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = mini_hipatterns.gen_highlighter.hex_color(),
      },
    })
  end
}
