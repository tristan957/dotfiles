local utils = require("tristan957.lsp.utils")

return {
  cmd = { "cmake-language-server" },
  init_options = {
    buildDirectory = "build",
  },
  root_dir = utils.root_dir({
    "CMakePresets.json",
    "CTestConfig.cmake",
    "cmake",
  }),
}
