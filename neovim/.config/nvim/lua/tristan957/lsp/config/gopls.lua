local utils = require("tristan957.lsp.utils")

return {
  cmd = { "gopls" },
  root_dir = utils.root_dir({ "go.mod", "go.work" }),
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
}
