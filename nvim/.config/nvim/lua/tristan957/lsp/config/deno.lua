local utils = require("tristan957.lsp.utils")

return {
  cmd = { "deno", "lsp" },
  root_dir = utils.root_dir({ "deno.json", "deno.jsonc" }),
  settings = {
    deno = {
      enable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
          },
        },
      },
    },
  },
}
