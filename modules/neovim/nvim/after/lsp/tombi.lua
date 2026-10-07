---@module "lspconfig"

---@type vim.lsp.Config
return {
  settings = {
    ---@type lspconfig.settings.tombi
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
