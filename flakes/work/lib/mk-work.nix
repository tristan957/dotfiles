# Build a work Home Manager configuration.
#
# Wraps the dotfiles `mkHome` and layers on the common work modules. Takes the
# same `{ system, machine }` argument every `machines/*.nix` returns.
{
  inputs,
  mkHome,
  homeModules,
}: args:
(mkHome (args
  // {
    extraSpecialArgs = {
      inputs = inputs.dotfiles.inputs // inputs;
      inherit homeModules;
    };
  })) .extendModules {
  modules =
    [
      inputs.amzn.homeModules.default
    ]
    ++ (with homeModules; [
      ada
      aim
      axe
      barium
      brazilcli
      builder-mcp
      claude-code
      cr
      grasp-tools
      isengard
      kiro
      midway
      opencode
      toolbox
    ]);
}
