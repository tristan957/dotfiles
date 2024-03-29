local utils = require("tristan957.lsp.utils")

return {
  cmd = { "zls" },
  root_dir = utils.root_dir({ "zls.json", "build.zig" }),
}
