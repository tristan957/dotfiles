---@type vim.lsp.Config
return {
  settings = {
    taplo = {
      schema = {
        enabled = true,
        associations = {
          ["^.*config/jj/.*\\.toml$"] = "https://jj-vcs.github.io/jj/latest/config-schema.json",
        },
      },
    },
  },
}
