---@type vim.lsp.Config
return {
  cmd = { "nixd", "--inlay-hints", "--semantic-tokens" },
  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
    },
  },
}
