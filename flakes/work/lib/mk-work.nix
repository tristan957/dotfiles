# Build a work Home Manager configuration.
#
# Wraps the dotfiles `mkHome` and layers on the common work modules (the amzn
# base module, midway, and the Builder Toolbox tooling). Takes the same
# `{ system, machine }` argument every `machines/*.nix` returns.
#
# Machine functions and modules receive `inputs` (this flake's inputs, so
# `inputs.dotfiles.homeModules` reaches the shared modules) and `homeModules`
# (this flake's work modules) as module arguments, injected via `mkHome`'s
# `extraSpecialArgs`.
#
# Note that overriding `inputs` replaces the value the dotfiles flake would
# otherwise inject, so a shared module that referenced `inputs` directly would
# see this flake's inputs instead. None currently do.
{
  inputs,
  mkHome,
  homeModules,
}: args:
(mkHome (args
  // {
    extraSpecialArgs = {inherit inputs homeModules;};
  }))
  .extendModules {
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
