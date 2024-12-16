---@module "lspconfig"

---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
return {
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.subr)",
    },
  },
}
