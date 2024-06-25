local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazy_path) then
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

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { 80, 100, 120 }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = { "line" }
vim.opt.encoding = "UTF-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.jumpoptions = { "view" }
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "⭢ " }
vim.opt.magic = true
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.secure = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append("Ic")
vim.opt.showbreak = "++++"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.writebackup = false

vim.g.c_syntax_for_h = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.markdown_fenced_languages = {
  "ts=typescript", -- Because of Deno's language server
}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  source = true,
  float = { border = "rounded" },
})

-- TODO: Set these up:
-- https://github.com/mrcjkb/rustaceanvim
-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/pmizio/typescript-tools.nvim
require("lazy").setup("plugins", {
  change_detection = {
    enabled = false,
    notify = false,
  },
  dev = {
    path = table.concat({ os.getenv("HOME"), "Projects" }, "/"),
  },
  install = {
    colorscheme = { "default" },
  },
  rocks = {
    enabled = true,
  },
  ui = {
    border = "rounded",
  },
})

vim.cmd.packadd("cfilter")

require("tristan957")
