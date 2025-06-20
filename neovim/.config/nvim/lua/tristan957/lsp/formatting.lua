local M = {}

---@type { [number]: vim.lsp.Client }
local formatters = {}

---@type { [string]: boolean | string[] }
local ls_markers = {
  biome = {
    "biome.json",
  },
  clangd = {
    ".clang-format",
  },
  gopls = true,
  lua_ls = false,
  terraformls = true,
  ts_ls = false,
  rust_analyzer = {
    ".rustfmt.toml",
    "rustfmt.toml",
  },
}

--- Get client for formatting a buffer.
---@param bufnr integer Buffer number
---@return vim.lsp.Client?
local function get_formatting_client(bufnr)
  local client = vim.tbl_get(formatters, bufnr)
  if client ~= nil then
    return client
  end

  local clients = vim
    .iter(vim.lsp.get_clients({ bufnr = bufnr }))
    :filter(
      ---@param c vim.lsp.Client
      function(c)
        return c:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) and ls_markers[c.name] ~= false
      end
    )
    :totable()

  if #clients == 0 then
    return nil
  end

  if #clients > 1 then
    local choices = vim
      .iter(clients)
      :map(
        ---@param c vim.lsp.Client
        function(c)
          return c.name
        end
      )
      :totable()

    vim.ui.select(choices, { prompt = "Select a formatter" }, function(_, choice)
      if not choice then
        vim.notify("No formatter selected", vim.log.levels.WARN)
        return
      end

      client = clients[choice]
    end)
  else
    client = clients[1]
  end

  formatters[bufnr] = client

  return client
end

---@param bufnr number
M.format = function(bufnr)
  local client = get_formatting_client(bufnr)
  if client == nil then
    return
  end

  local markers = ls_markers[client.name]
  if markers == nil then
    return
  end

  if type(markers) == "boolean" then
    if markers then
      vim.lsp.buf.format({
        bufnr = bufnr,
        async = true,
        id = client.id,
      })
    end

    return
  end

  ---@cast markers string[]
  local dir = vim.fs.root(0, markers)

  if dir ~= nil then
    vim.lsp.buf.format({
      bufnr = bufnr,
      async = true,
      id = client.id,
    })
  end
end

return M
