local comlink = require("comlink")

local proc = assert(io.popen("op --account my.1password.com read op://Personal/chat.sr.ht/credential", "r"))
local pass = proc:read("*l")
proc:close()

comlink.connect({
  server = "chat.sr.ht",
  tls = true,
  user = "tristan957",
  nick = "tristan957",
  real_name = "Tristan Partin",
  pass = pass,
})
