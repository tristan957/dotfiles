local comlink = require("comlink")

local proc =
  assert(io.popen("op --account my.1password.com read op://Personal/chat.sr.ht/credential", "r"))
local password = proc:read("*l")
proc:close()

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

  local s = string.gsub(cmdline, "%*%*(.+)%*%*", "\x02%1\x02")
  s = string.gsub(s, "%*(.+)%*", "\x1D%1\x1D")
  s = string.gsub(s, "~(.+)~", "\x1E%1\x1E")
  s = string.gsub(s, "_(.+)_", "\x1F%1\x1F")

  channel:send_msg(s)
end

comlink.add_command("fmt", format)

comlink.bind("ctrl+alt+j", "next-channel")
comlink.bind("ctrl+alt+k", "prev-channel")
