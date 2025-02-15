---@module "lspconfig"

---@type lspconfig.Config | {}
return {
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.subr)",
    },
  },
}
