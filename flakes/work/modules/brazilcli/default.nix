{
  # Upstream enables the tool and generates ~/.config/brazil/brazil.prefs,
  # which on darwin includes the BrazilPlatformOverlay/macos platform overlay.
  programs.toolbox.brazil-cli.enable = true;
}
