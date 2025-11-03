---@type vim.lsp.Config
return {
  -- Disable deno unless we know for sure that this is a Deno project
  enabled = vim.fn.filereadable("deno.json") == 1,
}
