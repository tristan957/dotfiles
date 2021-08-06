local lsp_status = require("lsp-status")

lsp_status.config({
	indicator_errors = "E",
	indicator_warnings = "W",
	indicator_info = "i",
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
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()", { noremap = true })

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	lsp_status.on_attach(client)
end

local configs = {
	lua = { -- sumneko_lua
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
		on_attach = on_attach,
	},
}

local function setup_servers()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()
	for _, server in pairs(servers) do
		require("lspconfig")[server].setup(configs[server] or { on_attach = on_attach })
	end
end

setup_servers()

require("lspinstall").post_install_hook = function()
	setup_servers()
	vim.cmd("bufdo e")
end

require("lspconfig").clangd.setup({
	on_attach = on_attach,
})
