local group = vim.api.nvim_create_augroup("tristan957_lsp", { clear = true })

vim.lsp.set_log_level("OFF")

if vim.fn.has("nvim-0.11") == 1 then
  vim.lsp.enable({
    "awkls",
    "basedpyright",
    "bashls",
    "biome",
    "blueprint_ls",
    "clangd",
    "cmake",
    "cssls",
    "denols",
    "dockerls",
    "gleam",
    "gopls",
    "harper_ls",
    "helm_ls",
    "html",
    "jqls",
    "jsonls",
    "jsonnet_ls",
    "kcl",
    "lemminx",
    "lua_ls",
    "marksman",
    "muon",
    -- "pyright",
    "ruff",
    "rust_analyzer",
    "systemd_ls",
    "taplo",
    "terraformls",
    "tilt_ls",
    "ts_ls",
    "tinymist",
    "vacuum",
    "vimls",
    "yamlls",
    "zls",
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local picker = require("tristan957.picker")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client ~= nil)

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", picker.lsp_definitions, "Goto definitions")
    map("n", "gD", picker.lsp_declarations, "Goto declarations")
    map("n", "gy", picker.lsp_type_definitions, "Goto type definitions")
    map("n", "g(", "<CMD>Trouble lsp_incoming_calls focus<CR>", "Show incoming calls")
    map("n", "g)", "<CMD>Trouble lsp_outgoing_calls focus<CR>", "Show outgoing calls")
    map("n", "gra", vim.lsp.buf.code_action, "View code actions")
    map("n", "gO", picker.lsp_document_symbols, "Search document symbols")
    map("n", "<Leader>gO", picker.lsp_workspace_symbols, "Search workspace symbols")

    -- if client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    -- end

    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Format on save",
      buffer = ev.buf,
      callback = function(bwp_ev)
        local formatting = require("tristan957.lsp.formatting")

        formatting.format(bwp_ev.buf)
      end,
    })
  end,
})
