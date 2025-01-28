local group = vim.api.nvim_create_augroup("tristan957_lsp", { clear = true })

vim.lsp.set_log_level("OFF")

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local picker = require("tristan957.picker")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client ~= nil)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.bo[ev.buf].formatexpr = "v:lua.vim.lsp.formatexpr"

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", picker.lsp_definitions, "Goto definitions")
    map("n", "gD", picker.lsp_declarations, "Goto declarations")
    map("n", "gy", picker.lsp_type_definitions, "Goto type definitions")
    map("n", "gri", picker.lsp_implementations, "Show implementations")
    map("n", "grr", picker.lsp_references, "Show references")
    map("n", "g(", "<CMD>Trouble lsp_incoming_calls focus<CR>", "Show incoming calls")
    map("n", "g)", "<CMD>Trouble lsp_outgoing_calls focus<CR>", "Show outgoing calls")
    map({ "i", "s" }, "<C-S>", vim.lsp.buf.signature_help, "Show signature help")
    map("n", "grn", vim.lsp.buf.rename, "Rename")
    map("n", "gra", vim.lsp.buf.code_action, "View code actions")
    map("n", "gO", picker.lsp_document_symbols, "Search document symbols")
    map("n", "<Leader>gO", picker.lsp_workspace_symbols, "Search workspace symbols")
  end,
})

require("tristan957.lsp.handlers")

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format on save",
  callback = function(ev)
    local formatting = require("tristan957.lsp.formatting")

    formatting.format(ev.buf)
  end,
})
