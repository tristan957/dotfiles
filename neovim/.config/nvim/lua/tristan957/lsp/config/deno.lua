---@module "lspconfig"

---@type lspconfig.Config | {}
return {
  -- Disable deno unless we know for sure that this is a Deno project
  enabled = (function()
    local _, err = vim.uv.fs_stat("deno.json")
    return err == nil
  end)(),
}
