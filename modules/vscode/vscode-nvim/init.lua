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

local vscode = require("vscode")

vim.notify = vscode.notify

--No idea why this is necessary: https://github.com/vscode-neovim/vscode-neovim/issues/1137#issuecomment-1936954633
vim.keymap.set("", "<Space>", "<Nop>")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.autoread = true
vim.opt.backup = false
vim.opt.exrc = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 250
vim.opt.writebackup = false

vim.keymap.set("n", "<leader><leader>", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Go to file" })
vim.keymap.set("n", "[t", function()
  vscode.action("workbench.action.previousEditor")
end, { desc = "Previous tab" })
vim.keymap.set("n", "]t", function()
  vscode.action("workbench.action.nextEditor")
end, { desc = "Next tab" })

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
  rocks = {
    enabled = true,
  },
})

require("tristan957")
