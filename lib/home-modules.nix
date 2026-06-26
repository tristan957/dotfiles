# Auto-generate the set of Home Manager modules from the `modules/` directory.
#
# Every immediate subdirectory of `modulesDir` that contains a `default.nix`
# becomes an attribute whose value is the imported module, e.g.
# `homeModules.git = import ./modules/git`. This keeps the flake's exposed
# `homeModules` in sync with the directory layout automatically.
#
# Directory names that are not valid bare Nix identifiers (e.g. `1password`,
# which starts with a digit) are additionally exposed under a sanitised alias
# with a leading underscore (`_1password`), mirroring nixpkgs conventions, so
# they can be used inside `with homeModules; [ ... ]`.
modulesDir: let
  entries = builtins.readDir modulesDir;

  isModule = name: type:
    type == "directory" && builtins.pathExists (modulesDir + "/${name}/default.nix");

  moduleNames = builtins.filter (name: isModule name entries.${name}) (builtins.attrNames entries);

  # Prefix names that start with a digit so they form valid identifiers.
  alias = name:
    if builtins.match "[0-9].*" name != null
    then "_${name}"
    else name;
in
  builtins.listToAttrs (
    builtins.concatMap (
      name: let
        value = import (modulesDir + "/${name}");
        aliased = alias name;
      in
        [{inherit name value;}]
        ++ (
          if aliased != name
          then [
            {
              name = aliased;
              inherit value;
            }
          ]
          else []
        )
    )
    moduleNames
  )
