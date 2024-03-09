local utils = require("tristan957.lsp.utils")

return {
  cmd = { "ruff-lsp" },
  root_dir = utils.root_dir({ "pyproject.toml", "setup.py", "ruff.toml" }),
}
