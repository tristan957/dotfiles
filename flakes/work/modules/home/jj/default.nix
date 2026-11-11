{
  config,
  pkgs,
  ...
}: {
  # programs.jujutsu has no conf.d support, so write the scoped config directly
  # next to the config.toml it generates.
  home.file."${config.xdg.configHome}/jj/conf.d/work.toml".source = (pkgs.formats.toml {}).generate "jujutsu-work-config" {
    "--when".repositories = ["~/Projects/work"];

    user.email = "dbltap@amazon.com";
  };
}
