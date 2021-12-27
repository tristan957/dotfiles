local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd("packadd packer.nvim")

require("packer").startup(function(use)
	use({
		"folke/trouble.nvim",
	})

	use({
		"folke/todo-comments.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("tristan957.todo-comments")
		end,
	})

	use({
		"folke/zen-mode.nvim",
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-calc" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-path" },
			{ "nvim-neorg/neorg" },
			{
				"saadparwaiz1/cmp_luasnip",
				requires = { "L3MON4D3/LuaSnip" },
			},
		},
		config = function()
			require("tristan957.cmp")
		end,
	})

	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
	})

	use({
		"L3MON4D3/LuaSnip",
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("tristan957.gitsigns")
		end,
	})

	use({
		"mfussenegger/nvim-dap",
	})

	use({
		"nvim-neorg/neorg",
		after = { "nvim-treesitter/nvim-tresitter" },
		requires = { { "nvim-lua/plenary.nvim" } },
		disable = true, -- when th grammar is supported by upstream nvim-treesitter
		config = function()
			require("tristan957.neorg")
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "nvim-lua/lsp-status.nvim" },
		},
		config = function()
			require("tristan957.lspconfig")
		end,
	})

	use({
		"nvim-lua/lsp-status.nvim",
	})

	use({
		"nvim-lua/popup.nvim",
	})

	use({
		"nvim-lua/plenary.nvim",
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("tristan957.lualine")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-packer.nvim" },
		},
		config = function()
			require("tristan957.telescope")
		end,
	})

	use({
		"nvim-treesitter/playground",
		requires = { { "nvim-treesitter/nvim-treesitter" } },
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		requires = { { "nvim-treesitter/nvim-treesitter" } },
	})

	use({
		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		config = function()
			require("tristan957.go")
		end,
	})

	use({
		"rcarriga/nvim-dap-ui",
		requires = { { "mfussenegger/nvim-dap" } },
		config = function()
			require("tristan957.dap-ui")
		end,
	})

	use({
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		config = function()
			require("tristan957.rust-tools")
		end,
	})

	use({
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("tristan957.git-worktree")
		end,
	})

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("tristan957.refactoring")
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
