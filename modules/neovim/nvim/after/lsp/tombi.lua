---@module "lspconfig"

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.tombi
  settings = {
    tombi = {
      schemas = {
        {
          include = { "**/jj/**/*.toml" },
          path = "https://docs.jj-vcs.dev/latest/config-schema.json",
        },
      },
    },
  },
}
