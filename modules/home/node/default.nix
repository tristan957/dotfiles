{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.node;
in {
  options.dotfiles.node.package = lib.mkPackageOption pkgs "nodejs" {nullable = true;};

  config = {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    home.sessionVariables = {
      NODE_REPL_HISTORY = "${config.xdg.stateHome}/node/history";
    };

    home.activation.createNodeStateDir =
      config.lib.activation.mkDir "${config.xdg.stateHome}/node";
  };
}
