---@type vim.lsp.Config
return {
  filetypes = {
    "gitcommit",
    -- "mail",
  },
  settings = {
    ["harper-ls"] = {
      dialect = "American",
      userDictPath = vim.fs.joinpath(
        vim.env.HOME,
        "dotfiles",
        "modules",
        "home",
        "harper",
        "dictionary.txt"
      ),
    },
  },
}
