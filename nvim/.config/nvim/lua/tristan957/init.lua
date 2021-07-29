require("tristan957.lualine")
require("tristan957.tree-sitter")
require("tristan957.lsp")
require("tristan957.telescope")
require("tristan957.nvim-compe")
require("tristan957.gitsigns")
require("tristan957.trouble")

vim.cmd(
	[[
		set foldmethod=expr
		set foldexpr=nvim_treesitter#foldexpr()
		set nofoldenable
	]]
)
