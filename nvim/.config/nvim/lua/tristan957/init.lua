require('tristan957.tree-sitter')
require('tristan957.lsp')
require('tristan957.telescope')

vim.cmd(
	[[
		set foldmethod=expr
		set foldexpr=nvim_treesitter#foldexpr()
		set nofoldenable
	]]
)
