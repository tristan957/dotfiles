local lsp_status = require("lsp-status")

lsp_status.config({
	indicator_errors = "E",
	indicator_warnings = "W",
	indicator_info = "i",
	indicator_hint = "?",
	indicator_ok = "ok"
})

lsp_status.register_progress()

local function on_attach(client, bufnr)
	lsp_status.on_attach(client)
end

require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
})

require("lspconfig").clangd.setup({
	on_attach = on_attach,
})

require("lspconfig").gopls.setup({
	on_attach = on_attach,
})

require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
})
