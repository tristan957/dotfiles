return {
  "echasnovski/mini.misc",
  config = function()
    local MiniMisc = require("mini.misc")

    MiniMisc.setup()

    MiniMisc.setup_restore_cursor()

    -- Ghostty does this for us
    local term = vim.env.TERM
    if term ~= nil and (term ~= "xterm-ghostty" and term ~= "ghostty") then
      MiniMisc.setup_termbg_sync()
    end
  end,
}
