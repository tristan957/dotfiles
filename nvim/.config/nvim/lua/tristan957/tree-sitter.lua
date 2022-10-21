require("nvim-treesitter.configs").setup({
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

print("hello")

vim.cmd([[
		set foldmethod=expr
		set foldexpr=nvim_treesitter#foldexpr()
		set nofoldenable
	]])
