local utils = require("tristan957.lsp.utils")

return {
  cmd = { "vscode-html-language-server", "--stdio" },
  root_dir = utils.root_dir({ "package.json" }),
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
}
