{...}: {
  config = {
    xdg.configFile."hunk/config.toml" = {
      text =
        # toml
        ''
          mode = "auto"
          tab_width = 4
        '';
    };
  };
}
