local utils = require("tristan957.lsp.utils")

return {
  cmd = { "marksman", "server" },
  root_dir = utils.root_dir({ ".marksman.toml" }),
}
