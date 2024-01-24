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

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { 80, 100, 120 }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.encoding = "UTF-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading "
  vim.opt.grepformat = "%f:%l:%c:%m"
end
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
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
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("Ic")
vim.opt.showbreak = "++++"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.writebackup = false

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
