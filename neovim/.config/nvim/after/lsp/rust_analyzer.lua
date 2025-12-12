---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        targetDir = true,
      },
      check = {
        command = "clippy",
      },
    },
  },
}
