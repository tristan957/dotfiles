local M = {}

---@type { [string]: string[] }
local markers = {
  clangd = {
    ".clang-format",
  },
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
  if markers[client.name] == nil then
    return
  end

  local dir = vim.fs.root(0, markers[client.name])

  if force or dir ~= nil then
    if type(client) == "string" then
      opts["name"] = client
    else
      opts["id"] = client.id
    end

    vim.lsp.buf.format({
      bufnr = bufnr,
      unpack(opts),
    })
  end
end

return M
