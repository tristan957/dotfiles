{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.amzn.packages.${pkgs.stdenv.hostPlatform.system}.mcurl
  ];

  services.midway.aea.cookie-refresh.enable = true;
}
