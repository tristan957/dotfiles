---@module "lspconfig"

--- https://cs.opensource.google/go/x/tools/+/master:gopls/doc/
---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
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
