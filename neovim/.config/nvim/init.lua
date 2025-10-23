local lazy_path = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazy_path) then
  vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path,
    })
    :wait()
end

vim.opt.runtimepath:prepend(lazy_path)

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { 80, 100, 120 }
vim.opt.completeopt:append("noselect")
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = { "line" }
vim.opt.encoding = "UTF-8"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.foldenable = false
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
vim.opt.mouse = "nvi"
vim.opt.mousescroll = "ver:1,hor:6"
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.secure = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append("Ic")
vim.opt.showbreak = "+++ "
vim.opt.showcmd = true
vim.opt.showcmdloc = "last"
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

if vim.fn.has("nvim-0.11") == 1 then
  vim.opt.completeopt:append("fuzzy")
  vim.opt.tabclose = "uselast"
  vim.opt.winborder = "single"
end

vim.g.c_syntax_for_h = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.markdown_fenced_languages = {
  "ts=typescript", -- Because of Deno's language server
}
vim.g.omni_sql_no_default_maps = 1

vim.g.project_settings_opts = {
  fs_root = vim.fs.joinpath(vim.env.HOME, "Projects"),
  rtps_root = vim.fs.joinpath(
    vim.fn.stdpath("config") --[[@as string]],
    "lua",
    "tristan957",
    "runtimepaths"
  ),
} --[[@as ProjectSettingsOpts]]

require("lazy").setup("plugins", {
  change_detection = {
    enabled = false,
    notify = false,
  },
  dev = {
    path = vim.fs.joinpath(vim.env.HOME, "Projects"),
  },
  diff = {
    cmd = "git",
  },
  install = {
    colorscheme = { "default" },
  },
  rocks = {
    enabled = true,
  },
  ui = {
    border = vim.fn.has("+winborder") == 1 and vim.o.winborder or "single",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "User: fix backdrop for lazy window",
  pattern = "lazy_backdrop",
  group = vim.api.nvim_create_augroup("lazynvim-fix", { clear = true }),
  callback = function(ctx)
    local win = vim.fn.win_findbuf(ctx.buf)[1]
    vim.api.nvim_win_set_config(win, { border = "none" })
  end,
})

vim.cmd.packadd("cfilter")

require("tristan957")
