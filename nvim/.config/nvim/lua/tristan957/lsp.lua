local function on_attach(client, bufnr)
end

require('lspconfig').rust_analyzer.setup {
	on_attach = on_attach,
}

require('lspconfig').clangd.setup{
	on_attach = on_attach,
}

require('lspconfig').gopls.setup{
	on_attach = on_attach,
}
