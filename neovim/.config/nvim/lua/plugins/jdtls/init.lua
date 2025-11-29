---@module "jdtls",
---@module "lazy"

---@type LazySpec
return {
  "mfussenegger/nvim-jdtls",
  enabled = true,
  ft = "java",
  config = function()
    local jdtls = require("jdtls")

    jdtls.start_or_attach({})
  end,
}
