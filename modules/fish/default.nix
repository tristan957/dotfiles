{
  config,
  lib,
  ...
}: {
  options.modules.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf config.modules.fish.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
      '';

      shellInit = ''
        # Nix
        # Multi-user (daemon) installation
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish 2>/dev/null
        # Fedora
        source /etc/profile.d/nix-daemon.fish 2>/dev/null
        # Single-user installation
        source "$XDG_STATE_HOME/nix/profile/etc/profile.d/nix.fish" 2>/dev/null

        # Make sure local binaries override everything
        fish_add_path --prepend --move "$HOME/.local/bin"
      '';
    };

    xdg.configFile = {
      "fish/conf.d/10-aliases.fish".source = ./10-aliases.fish;
      "fish/conf.d/10-bash.fish".source = ./10-bash.fish;
      "fish/conf.d/10-cursor.fish".source = ./10-cursor.fish;
      "fish/conf.d/10-keybindings.fish".source = ./10-keybindings.fish;
      "fish/conf.d/10-title.fish".source = ./10-title.fish;
      "fish/functions/add_pkg_config_path.fish".source = ./add_pkg_config_path.fish;
      "fish/functions/fish_mode_prompt.fish".source = ./fish_mode_prompt.fish;
      "fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
      "fish/functions/fish_user_key_bindings.fish".source = ./fish_user_key_bindings.fish;
    };
  };
}
