local utils = require("tristan957.lsp.utils")

return {
  cmd = { "mesonlsp", "--lsp" },
  root_dir = utils.root_dir({ "meson.options", "meson_options.txt" }),
}
