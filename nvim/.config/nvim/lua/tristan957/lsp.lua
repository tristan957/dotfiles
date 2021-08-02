local lsp_status = require("lsp-status")

lsp_status.config({
	indicator_errors = "E",
	indicator_warnings = "W",
	indicator_info = "i",
	indicator_hint = "?",
	indicator_ok = "ok",
})

lsp_status.register_progress()

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gd",
		"<cmd>lua vim.lsp.buf.definition()<CR>",
		{ noremap = true }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gD",
		"<cmd>lua vim.lsp.buf.declaration()<CR>",
		{ noremap = true }
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()", { noremap = true })
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
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
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
	on_attach = on_attach,
})
