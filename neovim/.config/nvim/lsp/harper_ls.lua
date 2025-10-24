local xdg = require("tristan957.utils.xdg")

---@type vim.lsp.Config
return {
  filetypes = {
    "gitcommit",
  },
  settings = {
    harper_ls = {
      userDictPath = vim.fs.joinpath(xdg.config_home(), "harper-ls", "dictionary.txt"),
    },
  },
}
