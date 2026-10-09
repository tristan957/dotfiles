local M = {}

---Prompt the user to select an LSP client, then invoke the callback.
---@param clients vim.lsp.Client[]
---@param opts { prompt?: string }
---@param callback fun(client: vim.lsp.Client)
M.select = function(clients, opts, callback)
  local choices = vim
    .iter(clients)
    :map(
      ---@param c vim.lsp.Client
      function(c)
        return c.name
      end
    )
    :totable()

  vim.ui.select(choices, { prompt = opts.prompt or "Select a language server" }, function(_, choice)
    if not choice then
      return
    end

    callback(clients[choice])
  end)
end

return M
