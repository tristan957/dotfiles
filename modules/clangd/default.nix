{pkgs, ...}: let
  configPath =
    if pkgs.stdenv.hostPlatform.isDarwin
    then "Library/Preferences/clangd/config.yaml"
    else ".config/clangd/config.yaml";
in {
  config = {
    home.file.${configPath}.source = ./config.yaml;
  };
}
