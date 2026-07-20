{inputs, ...}: let
  mcp = import ../../lib/mcp.nix {
    inherit (inputs.dotfiles.lib.mcp) mkLocal;
  };
in {
  programs.opencode.settings = {
    enabled_providers = ["amazon-bedrock"];

    mcp = inputs.dotfiles.lib.mcp.opencode.generate [mcp.servers.builder-mcp];

    provider."amazon-bedrock".options = {
      region = "us-east-1";
      profile = "dbltap";
    };

    share = "disabled";
  };
}
