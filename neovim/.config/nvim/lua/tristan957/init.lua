-- Always load project settings first
require("tristan957.project-settings").setup({
  fs_root = vim.fs.joinpath(vim.env.HOME, "Projects"),
  rtps_root = vim.fs.joinpath(
    vim.fn.stdpath("config") --[[@as string]],
    "lua",
    "tristan957",
    "runtimepaths"
  ),
})

require("tristan957.buffers")
require("tristan957.chcompdb")
require("tristan957.diagnostics")
require("tristan957.linenumbers")
require("tristan957.lsp")
require("tristan957.quickfix")
require("tristan957.search")
require("tristan957.whitespace")
require("tristan957.yank")
