{
  config,
  lib,
  ...
}: {
  config = {
    programs.devenv = {
      enable = true;
    };

    programs.mcp = {
      enable = true;
      servers.devenv = {
        command = lib.getExe config.programs.devenv.package;
        args = ["mcp"];
      };
    };
  };
}
