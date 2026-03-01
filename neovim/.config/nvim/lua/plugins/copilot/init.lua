---@module "lazy"

---@type LazySpec
return {
  "github/copilot.vim",
  event = { "BufNewFile", "BufReadPre" },
  cmd = "Copilot",
}
