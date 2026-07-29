---@type vim.lsp.Config
return {
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
