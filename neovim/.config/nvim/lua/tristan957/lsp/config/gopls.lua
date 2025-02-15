---@module "lspconfig"

--- https://cs.opensource.google/go/x/tools/+/master:gopls/doc/
---@type lspconfig.Config | {}
return {
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
}
