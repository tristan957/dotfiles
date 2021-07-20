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

-- Seems like vim-plug doesn't correctly add lua-based plugins to the rtp
vim.cmd(
	[[
		let &runtimepath .= ',' . stdpath('data') . '/plugged/popup.nvim'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/plenary.nvim'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/telescope.nvim'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/telescope-fzf-native.nvim'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/nvim-treesitter'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/nvim-lspconfig'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/git-worktree.nvim'
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
