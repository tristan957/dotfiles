---@type LazySpec {
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local jdtls = require("jdtls")

    jdtls.start_or_attach()
  end,
}
