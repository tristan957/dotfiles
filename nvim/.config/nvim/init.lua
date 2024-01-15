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
vim.o.backup = false
vim.o.cmdheight = 2
vim.o.colorcolumn = "80,100,120"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.encoding = "UTF-8"
vim.o.errorbells = false
vim.o.expandtab = true
if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --no-heading "
  vim.o.grepformat = "%f:%l:%c:%m"
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
vim.o.number = true
vim.o.path = vim.o.path .. "**"
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
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 100
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildmenu = true
vim.o.wrap = false
vim.o.writebackup = false

vim.g.mapleader = " "
vim.g.maplocalleader = ","

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
require("lazy").setup("tristan957.plugins", {
  dev = {
    path = table.concat({ os.getenv("HOME"), "Projects" }, "/"),
  },
  ui = {
    border = "rounded",
  },
})

-- Setup global keymaps
require("tristan957.keymaps")

-- Setup autocommands
require("tristan957.autocmds")
