local comlink = require("comlink")

local proc =
  assert(io.popen("op --account my.1password.com read op://Personal/chat.sr.ht/credential", "r"))
local password = proc:read("*l")
proc:close()

---@diagnostic disable-next-line:unused-local
local client = comlink.connect({
  server = "chat.sr.ht",
  tls = true,
  user = "tristan957",
  nick = "tristan957",
  real_name = "Tristan Partin",
  password = password,
})

comlink.bind("ctrl+alt+j", "next-channel")
comlink.bind("ctrl+alt+k", "prev-channel")
