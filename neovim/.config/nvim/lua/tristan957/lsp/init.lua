local group = vim.api.nvim_create_augroup("tristan957_lsp", { clear = true })

vim.lsp.set_log_level("OFF")

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local fzf = require("fzf-lua")
    local formatting = require("tristan957.lsp.formatting")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client ~= nil)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.bo[ev.buf].formatexpr = "v:lua.vim.lsp.formatexpr"

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", fzf.lsp_definitions, "Goto definitions")
    map("n", "gD", vim.lsp.buf.declaration, "Goto declarations")
    map("n", "gy", fzf.lsp_typedefs, "Goto type definitions")
    map("n", "gl", fzf.lsp_implementations, "Show implementations")
    map("n", "gr", fzf.lsp_references, "Show references")
    map("n", "g(", "<CMD>Trouble lsp_incoming_calls focus<CR>", "Show incoming calls")
    map("n", "g)", "<CMD>Trouble lsp_outgoing_calls focus<CR>", "Show outgoing calls")
    map({ "i", "n" }, "<C-S>", vim.lsp.buf.signature_help, "Show signature help")
    map("n", "crn", vim.lsp.buf.rename, "Rename")
    map("n", "crr", vim.lsp.buf.code_action, "View code actions")
    map("v", "<C-R>r", vim.lsp.buf.code_action, "View code actions")
    map("n", "<leader>2", fzf.lsp_document_symbols, "Search document symbols")
    map("n", "<leader>@", fzf.lsp_workspace_symbols, "Search workspace symbols")

    -- If more than one formatter, use selection
    map({ "n", "v" }, "|f", function()
      local clients = {}
      local choices = {}

      for _, c in pairs(vim.lsp.get_clients({ bufnr = ev.buf })) do
        if c.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
          table.insert(clients, c)
          table.insert(choices, c.name)
        end
      end

      if #choices > 1 then
        vim.ui.select(choices, { prompt = "Select a formatter" }, function(_, choice)
          if not choice then
            vim.notify("No formatter selected", vim.log.levels.WARN)
            return
          end

          formatting.format(clients[choice], ev.buf, true, { async = true })
        end)
      else
        formatting.format(clients[1], ev.buf, true, { async = true })
      end
    end, "Format code")

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight <cword> references",
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        desc = "Clean <cword> reference highlights",
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end

    if client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format on save",
        buffer = ev.buf,
        callback = function()
          formatting.format(client, ev.buf, false, { async = true })
        end,
      })
    end

    -- Workaround for https://github.com/neovim/neovim/issues/30985
    if client.name == "rust_analyzer" then
      for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
          if err ~= nil and err.code == -32802 then
            return
          end
          return default_diagnostic_handler(err, result, context, config)
        end
      end
    end
  end,
})

require("tristan957.lsp.handlers")
