local M = {}

---@type { [string]: boolean | string[] }
local ls_markers = {
  clangd = {
    ".clang-format",
  },
  gopls = true,
  ["rust_analyzer"] = {
    ".rustfmt.toml",
    "rustfmt.toml",
  }
}

---@param client vim.lsp.Client
---@param bufnr number
---@param force boolean If marker is not found,
---@param opts table
M.format = function(client, bufnr, force, opts)
  local markers = ls_markers[client.name]
  if markers == nil then
    return
  end

  opts["id"] = client.id

  if type(markers) == "boolean" then
    if markers then
      vim.lsp.buf.format({
        bufnr = bufnr,
        table.unpack(opts),
      })
    end

    return
  end

  ---@cast markers string[]
  local dir = vim.fs.root(0, markers)

  if force or dir ~= nil then
    vim.lsp.buf.format({
      bufnr = bufnr,
      table.unpack(opts),
    })
  end
end

return M
