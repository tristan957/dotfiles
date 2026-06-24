local hostname_aliases = {
  ["dev-dsk-dbltap-1e-bb0a005d.us-east-1.amazon.com"] = "dbltap-dev",
  ["dev-dsk-dbltap-1e-919e42c3.us-east-1.amazon.com"] = "dbltap-lts",
  ["50f265e950b3"] = "macbook",
}

local function hostname()
  local real = vim.fn.hostname()
  return hostname_aliases[real] or real
end

---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      options = {
        ["home-manager"] = {
          expr = string.format(
            '(builtins.getFlake (builtins.toString ./.)).homeConfigurations."%s@%s".options',
            vim.env.USER,
            hostname()
          ),
        },
      },
    },
  },
}
