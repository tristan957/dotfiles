local utils = require("tristan957.lsp.utils")

return {
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = utils.root_dir({ "tsconfig.json", "package.json", "jsconfig.json" }),
  init_options = { hostInfo = "neovim" },
}
