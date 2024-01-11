local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end

vim.opt.rtp:prepend(lazy_path)

vim.o.autoindent = true
vim.o.autoread = true
vim.o.background = "dark"
vim.o.cmdheight = 2
vim.o.colorcolumn = "80,100,120"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.encoding = "UTF-8"
vim.o.expandtab = true
if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --no-heading "
  vim.o.grepfmt = "%f:%l:%c:%m"
end
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = "space:·,tab:⭢ "
vim.o.magic = true
vim.o.nobackup = true
vim.o.noerrorbells = true
vim.o.noswapfile = true
vim.o.nowrap = true
vim.o.nowritebackup = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 5
vim.o.secure = true
vim.o.shiftwidth = 4
vim.o.shortmess = vim.o.shortmess .. "Ic"
vim.o.showbreak = "++++"
vim.o.showmatch = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 100
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildmenu = true

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.cmd("filetype plugin on")
vim.cmd("syntax enable")

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  source = true,
  float = { border = "rounded" },
})

-- TODO: Set these up:
-- https://github.com/mrcjkb/rustaceanvim
-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/pmizio/typescript-tools.nvim
require("lazy").setup({
  {
    "chrisbra/unicode.vim",
    event = "VeryLazy",
  },
  {
    "dart-lang/dart-vim-plugin",
    event = "VeryLazy",
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
  {
    'echasnovski/mini.ai',
    version = false,
    event = "VeryLazy",
    config = function()
      require("tristan957.plugins.mini-ai")
    end
  },
  {
    'echasnovski/mini.files',
    version = false,
    event = "BufEnter",
    config = function()
      require("tristan957.plugins.mini-files")
    end
  },
  {
    'echasnovski/mini.hipatterns',
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tristan957.plugins.mini-hipatterns")
    end
  },
  {
    'echasnovski/mini.move',
    version = false,
    event = "VeryLazy",
    config = function()
      require("tristan957.plugins.mini-move")
    end
  },
  {
    "folke/neodev.nvim",
    lazy = true,
  },
  {
    "folke/trouble.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tristan957.plugins.trouble")
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tristan957.plugins.todo-comments")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tristan957.plugins.tokyonight")
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-omni" },
      { "hrsh7th/cmp-path" },
      { "nvim-neorg/neorg" },
      { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip" },
      },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("tristan957.plugins.cmp")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tristan957.plugins.gitsigns")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    cmd = "DapContinue",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
      require("tristan957.plugins.dap-ui")
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "cmp-nvim-lsp",
      "folke/neodev.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("tristan957.plugins.lspconfig")
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "FileType",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("tristan957.plugins.comment")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "onedarkpro.nvim" },
    event = "UIEnter",
    config = function()
      require("tristan957.plugins.lualine")
    end,
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    ft = "norg",
    config = function()
      require("tristan957.plugins.neorg")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    event = "VeryLazy",
    config = function()
      require("tristan957.plugins.telescope")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tristan957.plugins.treesitter")
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme onedark_vivid")
      require("tristan957.plugins.onedarkpro")
    end,
  },
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("tristan957.plugins.go")
    end,
  },
  {
    "rcarriga/nvim-notify",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("tristan957.plugins.notify")
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("tristan957.plugins.refactoring")
    end,
  },
  {
    "tmux-plugins/vim-tmux",
    ft = "tmux",
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = "VeryLazy",
    config = function()
      require("tristan957.plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = true,
  },
}, {
  dev = {
    path = "~/Projects",
  },
  ui = {
    border = "single",
    icons = {
      cmd = "c ",
      config = "",
      event = "e ",
      ft = "ft ",
      init = "",
      import = "i ",
      keys = "k ",
      lazy = "l ",
      loaded = "●",
      not_loaded = "○",
      plugin = "p ",
      runtime = "r ",
      source = "s ",
      start = "* ",
      task = "t ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
})

-- Setup global keymaps
require("tristan957.keymaps")

-- Setup autocommands
require("tristan957.autocmds")
