vim.cmd(
	[[
		Plug 'ThePrimeagen/git-worktree.nvim'
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'
		Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
		Plug 'neovim/nvim-lspconfig'
	]]
)

-- Seems like vim-plug doesn't correctly add lua-based plugins to the rtp
vim.cmd(
	[[
		let &runtimepath .= ',' . stdpath('data') . '/plugged/plenary.nvim'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/telescope.nvim'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/nvim-treesitter'
		let &runtimepath .= ',' . stdpath('data') . '/plugged/nvim-lspconfig'
	]]
)

require('tristan957.tree-sitter')
require('tristan957.lsp')

vim.cmd(
	[[
		set foldmethod=expr
		set foldexpr=nvim_treesitter#foldexpr()
	]]
)
