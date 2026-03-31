local group = vim.api.nvim_create_augroup("tristan957_lsp", { clear = true })

vim.lsp.log.set_level("OFF")

vim.lsp.enable({
  --"basedpyright",
  "bashls",
  "biome",
  "blueprint_ls",
  "clangd",
  "cmake",
  "copilot",
  "cssls",
  "denols",
  "docker_language_server",
  "fish_lsp",
  "gleam",
  "gopls",
  "harper_ls",
  "helm_ls",
  "html",
  "jqls",
  "jsonls",
  "jsonnet_ls",
  "just",
  "kcl",
  "lemminx",
  "lua_ls",
  "marksman",
  "muon",
  "postgres_lsp",
  --"pyright",
  "ruff",
  "rust_analyzer",
  "stylua",
  "systemd_lsp",
  "taplo",
  "terraformls",
  "tilt_ls",
  "tinymist",
  "ts_ls",
  "ts_query_ls",
  "ty",
  "vacuum",
  "vimls",
  "yamlls",
  "zls",
})

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
    map("n", "g(", picker.lsp_incoming_calls, "Show incoming calls")
    map("n", "g)", picker.lsp_outgoing_calls, "Show outgoing calls")
    map("n", "grr", picker.lsp_references, "Show references")
    map("n", "gra", vim.lsp.buf.code_action, "View code actions")
    -- map("n", "grt", picker.lsp_type_definitions, "Goto type definition")
    -- map("n", "grx", vim.lsp.codelens.run, "Run code lens")
    map("n", "gO", picker.lsp_document_symbols, "Search document symbols")
    map("n", "go", picker.lsp_workspace_symbols, "Search workspace symbols")

    -- Enable codelens
    if client:supports_method("textDocument/codeLens", ev.buf) then
      vim.lsp.codelens.enable(true, { bufnr = ev.buf })
    end

    -- Enable completion
    --if client:supports_method("textDocument/completion") then
    --  vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    --end

    -- Enable document coloring
    if client:supports_method("textDocument/documentColor", ev.buf) then
      vim.lsp.document_color.enable(true, { bufnr = ev.buf })

      map("n", "<Leader>p", function()
        vim.lsp.document_color.color_presentation()
      end, "Select color presentation")
    end

    -- Enable inline completion
    if client:supports_method("textDocument/inlineCompletion", ev.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = ev.buf })

      map("i", "<C-.>", function()
        if not vim.lsp.inline_completion.get() then
          return "<C-.>"
        end
      end, "Accept inline completion")
      map("i", "<C-,>", vim.lsp.inline_completion.select, "Switch inline completion")
    end

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

require("tristan957.lsp.progress")
