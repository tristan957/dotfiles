local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

vim.cmd("packadd packer.nvim")

require("packer").startup({
  function(use)
    use({ "chrisbra/unicode.vim" })
    use({ "dart-lang/dart-vim-plugin", ft = { "dart" } })
    use({ "editorconfig/editorconfig-vim" })
    use({
      "EdenEast/nightfox.nvim",
      config = function() end,
    })
    use({
      "folke/trouble.nvim",
      config = function()
        require("tristan957.plugins.trouble")
      end,
    })
    use({
      "folke/todo-comments.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("tristan957.plugins.todo-comments")
      end,
    })
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("tristan957.plugins.tokyonight")
      end,
    })
    use({ "folke/zen-mode.nvim" })
    use({ "gruvbox-community/gruvbox" })
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-calc" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-emoji" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-omni" },
        { "hrsh7th/cmp-path" },
        { "nvim-neorg/neorg" },
        { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },
        {
          "saadparwaiz1/cmp_luasnip",
          requires = { "L3MON4D3/LuaSnip" },
        },
      },
      config = function()
        require("tristan957.plugins.cmp")
      end,
    })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      disable = true,
      config = function()
        require("tristan957.plugins.null-ls")
      end,
    })
    use({ "kevinoid/vim-jsonc" })
    use({ "L3MON4D3/LuaSnip" })
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("tristan957.plugins.gitsigns")
      end,
    })
    use({ "mfussenegger/nvim-dap" })
    use({
      "nvim-neorg/neorg",
      after = { "nvim-treesitter/nvim-tresitter" },
      requires = { "nvim-lua/plenary.nvim" },
      disable = true,
      config = function()
        require("tristan957.plugins.neorg")
      end,
    })
    use({
      "neovim/nvim-lspconfig",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "nvim-lua/lsp-status.nvim" },
      },
      config = function()
        require("tristan957.plugins.lspconfig")
      end,
    })
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("tristan957.plugins.comment")
      end,
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
    })
    use({ "nvim-lua/lsp-status.nvim" })
    use({ "nvim-lua/popup.nvim" })
    use({ "nvim-lua/plenary.nvim" })
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("tristan957.plugins.lualine")
      end,
      requires = { "olimorris/onedarkpro.nvim" },
    })
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-packer.nvim" },
        { "nvim-telescope/telescope-project.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = function()
        require("tristan957.plugins.telescope")
      end,
    })
    use({
      "nvim-treesitter/playground",
      requires = { "nvim-treesitter/nvim-treesitter" },
    })
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
      config = function()
        require("tristan957.plugins.treesitter")
      end,
    })
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      requires = { "nvim-treesitter/nvim-treesitter" },
    })
    use({
      "olimorris/onedarkpro.nvim",
      config = function()
        require("tristan957.plugins.onedarkpro")
        vim.cmd("colorscheme onedarkpro")
      end,
    })
    use({
      "ray-x/go.nvim",
      ft = { "go", "gomod" },
      config = function()
        require("tristan957.plugins.go")
      end,
    })
    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("tristan957.plugins.dap-ui")
      end,
    })
    use({
      "rcarriga/nvim-notify",
      requires = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("tristan957.plugins.notify")
      end,
    })
    use({ "rust-lang/rust.vim", ft = { "rust" } })
    use({
      "simrat39/rust-tools.nvim",
      ft = { "rust" },
      config = function()
        require("tristan957.plugins.rust-tools")
      end,
    })
    use({
      "ThePrimeagen/git-worktree.nvim",
      config = function()
        require("tristan957.plugins.git-worktree")
      end,
    })
    use({
      "ThePrimeagen/refactoring.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("tristan957.plugins.refactoring")
      end,
    })
    use({ "tmux-plugins/vim-tmux", ft = "tmux" })
    use({ "tpope/vim-fugitive" })
    use({ "tpope/vim-obsession" })
    use({ "tpope/vim-surround" })
    use({ "ziglang/zig.vim", ft = { "zig" } })
    use({ "wbthomason/packer.nvim" })
    use({
      "williamboman/mason.nvim",
      config = function()
        require("tristan957.plugins.mason")
      end,
    })
    use({ "williamboman/mason-lspconfig.nvim", required = { "williamboman/mason.nvim" } })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
