local utils = require("tristan957.lsp.utils")

return vim.tbl_deep_extend("force", utils.default_config, {
  cmd = { "bash-language-server", "start" },
  root_dir = utils.root_dir(),
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.subr)",
    },
  },
})
