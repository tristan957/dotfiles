{
  config,
  lib,
  pkgs,
  ...
}: let
  configPath =
    if pkgs.stdenv.isDarwin
    then "Library/Preferences/clangd/config.yaml"
    else ".config/clangd/config.yaml";
in {
  options.modules.clangd.enable = lib.mkEnableOption "clangd";

  config = lib.mkIf config.modules.clangd.enable {
    home.file.${configPath}.source = ./config.yaml;
  };
}
