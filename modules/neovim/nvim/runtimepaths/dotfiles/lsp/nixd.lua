local machines = {
  ["50f265e950b3"] = {
    alias = "macbook",
    work = true,
  },
  ["c-3po"] = {
    work = false,
  },
  ["dev-dsk-dbltap-1e-bb0a005d.us-east-1.amazon.com"] = {
    alias = "dbltap-dev",
    work = true,
  },
  ["dev-dsk-dbltap-1e-919e42c3.us-east-1.amazon.com"] = {
    alias = "dbltap-lts",
    work = true,
  },
}
local function home_manager_expr()
  local hostname = vim.fn.hostname()
  local machine = machines[vim.fn.hostname()]

  -- Work machines' homeConfigurations live in flakes/work, everything else in
  -- the root flake. The work flake's `dotfiles` input is a relative
  -- `path:../..`, which `getFlake` can only resolve when the flake is fetched
  -- as a subdir of the git tree (git+file://<root>?dir=flakes/work), not via
  -- a bare path.
  local flake
  if machine.work then
    -- Absolute path to the repository root (the directory holding the root
    -- flake.nix), so getFlake can fetch flakes/work as a subdir of the tree.
    local root = vim.fs.root(0, ".git") or vim.uv.cwd()
    flake = string.format('"git+file://%s?dir=flakes/work"', root)
  else
    flake = "(builtins.toString ./.)"
  end

  return string.format(
    '(builtins.getFlake %s).homeConfigurations."%s@%s".options',
    flake,
    vim.env.USER,
    vim.tbl_get(machine, "alias") or hostname
  )
end

---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      options = {
        -- nixd evaluates NixOS options from <nixpkgs> by default. None of this
        -- repo is NixOS, so point it at an empty option set to stop that.
        nixos = {
          expr = "{ }",
        },
        ["flake-parts"] = {
          expr = "(builtins.getFlake (builtins.toString ./.)).allSystems.${builtins.currentSystem}.options",
        },
        ["home-manager"] = {
          expr = home_manager_expr(),
        },
      },
    },
  },
}
