local utils = require("tristan957.lsp.utils")

return {
  cmd = { "terraform-ls", "serve" },
  root_dir = utils.root_dir({ ".terraform" }),
}
