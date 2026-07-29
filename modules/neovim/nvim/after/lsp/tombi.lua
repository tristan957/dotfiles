---@type vim.lsp.Config
return {
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
