---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = { "testing" },
        targetDir = true,
      },
      check = {
        command = "clippy",
      },
    },
  },
}
