local group = vim.api.nvim_create_augroup("tristan957/lsp", { clear = true })

-- vim.api.nvim_create_autocmd("FileType", {
--   group = group,
--   callback = function(ev)
--     local utils = require("tristan957.lsp.utils")
--
--     local servers = utils.servers(ev.buf)
--
--     for _, s in pairs(servers) do
--       local config = require("tristan957.lsp.config." .. s)
--       config = vim.tbl_deep_extend("force", utils.default_config, config)
--
--       pcall(vim.lsp.start, config, { bufnr = ev.buf })
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local builtin = require("telescope.builtin")
    local formatting = require("tristan957.lsp.formatting")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.bo[ev.buf].formatexpr = "v:lua.vim.lsp.formatexpr"

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", builtin.lsp_definitions, "Goto definitions")
    map("n", "gD", vim.lsp.buf.declaration, "Goto declarations")
    map("n", "gy", builtin.lsp_type_definitions, "Goto type definitions")
    map("n", "gl", builtin.lsp_implementations, "Show implementations")
    map("n", "gr", builtin.lsp_references, "Show references")
    map("n", "g(", builtin.lsp_incoming_calls, "Show incoming calls")
    map("n", "g)", builtin.lsp_outgoing_calls, "Show outgoing calls")
    map("n", "K", vim.lsp.buf.hover, "Show hover documentation")
    map({ "i", "n" }, "<C-S>", vim.lsp.buf.signature_help, "Show signature help")
    map("n", "crn", vim.lsp.buf.rename, "Rename")
    map("n", "crr", vim.lsp.buf.code_action, "View code actions")
    map("v", "<C-R>r", vim.lsp.buf.code_action, "View code actions")
    map("n", "<leader>2", builtin.lsp_document_symbols, "Search document symbols")
    map("n", "<leader>@", builtin.lsp_dynamic_workspace_symbols, "Search workspace symbols")

    -- If more than one formatter, use selection
    map({ "n", "v" }, "|f", function()
      local clients = {}
      local choices = {}

      for _, c in pairs(vim.lsp.get_active_clients({ bufnr = ev.buf })) do
        if c.server_capabilities.documentFormattingProvider then
          table.insert(clients, c)
          table.insert(choices, c.name)
        end
      end

      if #choices > 1 then
        vim.ui.select(choices, { prompt = "Select a formatter" }, function(_, choice)
          if not choice then
            vim.notify(vim.log.levels.WARN, "No formatter selected")
            return
          end

          formatting.format(clients[choice], ev.buf, true, { async = true })
        end)
      else
        formatting.format(clients[1], ev.buf, true, { async = true })
      end
    end, "Format code")

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight <cword> references",
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        desc = "Clean <cword> reference highlights",
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format on save",
        buffer = ev.buf,
        callback = function()
          formatting.format(client, ev.buf, false, { async = true })
        end,
      })
    end
  end,
})

-- vim.api.nvim_create_user_command("LspLog", function()
--   vim.cmd.tabnew(vim.lsp.get_log_path())
-- end, {
--   desc = "Opens the Nvim LSP client log",
-- })

require("tristan957.lsp.handlers")
