local comlink = require("comlink")

local proc =
  assert(io.popen("op --account my.1password.com read op://Personal/chat.sr.ht/credential", "r"))
local password = proc:read("*l")
proc:close()

comlink.setup({
  markread_on_focus = true,
})

comlink.connect({
  server = "chat.sr.ht",
  tls = true,
  user = "tristan957",
  nick = "tristan957",
  real_name = "Tristan Partin",
  password = password,
})

-- https://modern.ircdocs.horse/formatting
local function format(cmdline)
  local channel = comlink.selected_channel()
  if channel == nil then
    return
  end

  -- bold
  local s = string.gsub(cmdline, "%*%*(.+)%*%*", "\x02%1\x02")
  -- italics
  s = string.gsub(s, "%*(.+)%*", "\x1D%1\x1D")
  -- strikethrough
  s = string.gsub(s, "~(.+)~", "\x1E%1\x1E")
  -- underline
  s = string.gsub(s, "_(.+)_", "\x1F%1\x1F")
  -- monospace
  s = string.gsub(s, "`(.+)`", "\x11%1\x11")
  -- reverse
  s = string.gsub(s, "\\(.+)\\", "\x16%1\x16")

  channel:send_msg(s)
end

comlink.add_command("fmt", format)
comlink.bind("ctrl+j", "next-channel")
comlink.bind("ctrl+k", "prev-channel")
