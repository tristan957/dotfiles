local lsp_status = require("lsp-status")
local util = require("lspconfig.util")

local capabilities = require("cmp_nvim_lsp").update_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

lsp_status.config({
	indicator_errors = "E",
	indicator_warnings = "W",
	indicator_info = "I",
	indicator_hint = "?",
	indicator_ok = "ok",
	status_symbol = "",
})

lsp_status.register_progress()

local function on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true })
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true })
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true })

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.resolved_capabilities.goto_definition then
		buf_set_option("tagfunc", "v:lua.vim.lsp.tagfunc")
	end

	if client.resolved_capabilities.document_formatting then
		buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr")
	end

	lsp_status.on_attach(client)
end

require("lspconfig").bashls.setup({
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.subr)",
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

require("lspconfig").clangd.setup({
	cmd = {
		"clangd",
		"--header-insertion=never",
		"--all-scopes-completion=false",
		"--completion-style=bundled",
		"--cross-file-rename",
		"--enable-config",
		"--pch-storage=disk",
		"--header-insertion-decorators",
	},
	root_dir = util.root_pattern(
		"compile_commands.json",
		"compile_flags.txt",
		".git",
		"build/compile_commands.json",
		"*build*/compile_commands.json"
	),
	capabilities = capabilities,
	on_attach = on_attach,
})

-- https://cs.opensource.google/go/x/tools/+/master:gopls/doc/
require("lspconfig").gopls.setup({
	settings = {
		gopls = {
			analyses = {
				fieldalignment = true,
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

require("lspconfig").rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

require("lspconfig").sumneko_lua.setup({
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = {
					"?.lua",
					"?/init.lua",
					"?/?.lua",
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.expand("$VIMRUNTIME"),
					vim.fn.stdpath("data"),
				},
				preloadFileSize = 200,
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

require("lspconfig").zls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
