---@type vim.lsp.Config
return {
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true,
        associations = {
          ["^.*/jj/.*\\.toml$"] = "https://docs.jj-vcs.dev/latest/config-schema.json",
        },
      },
    },
  },
}
