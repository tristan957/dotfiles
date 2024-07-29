local capabilities = require("tristan957.lsp").capabilities

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
  capabilities = capabilities,
}
