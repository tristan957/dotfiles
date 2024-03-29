local utils = require("tristan957.lsp.utils")

return {
  cmd = { "vscode-css-language-server", "--stdio" },
  init_options = {
    provideFormatter = true,
  },
  root_dir = utils.root_dir({ "package.json" }),
  settings = {
    css = {
      validate = true,
    },
    scss = {
      validate = true,
    },
    less = {
      validate = true,
    },
  },
}
