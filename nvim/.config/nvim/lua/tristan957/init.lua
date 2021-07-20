vim.cmd(
	[[
		Plug 'ThePrimeagen/git-worktree.nvim'
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'
		Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
		Plug 'neovim/nvim-lspconfig'
		Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	]]
)

require('tristan957.tree-sitter')
require('tristan957.lsp')
require('tristan957.telescope')

vim.cmd(
	[[
		set foldmethod=expr
		set foldexpr=nvim_treesitter#foldexpr()
	]]
)
