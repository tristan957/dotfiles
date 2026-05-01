{
  lib,
  pkgs,
  ...
}: let
  configPath =
    if pkgs.stdenv.isDarwin
    then "Library/Preferences/clangd/config.yaml"
    else ".config/clangd/config.yaml";
in {
  home.file.${configPath}.source = ./config.yaml;
}
