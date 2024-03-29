local utils = require("tristan957.lsp.utils")

return {
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--all-scopes-completion=false",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--enable-config",
    "--pch-storage=disk",
    "--header-insertion-decorators",
  },
  root_dir = utils.root_dir({
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
  }),
}
