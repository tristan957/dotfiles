# Build a work Home Manager configuration.
#
# Wraps the dotfiles `mkHome` and layers on the common work modules (the amzn
# base module, midway, and the Builder Toolbox tooling). Takes the same
# `{ system, machine }` argument every `machines/*.nix` returns.
#
# Machine functions receive `dotfiles` (the dotfiles flake, for
# `dotfiles.homeModules`) and `homeModules` (this flake's work modules) as
# module arguments, injected via `mkHome`'s `extraSpecialArgs`. The work
# `homeModules` overrides the dotfiles `homeModules` that `mkHome` injects by
# default, so machine files reference shared modules via `dotfiles.homeModules`
# and work modules via `homeModules`.
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
      (homeModules.midway inputs.amzn)
    ]
    ++ (with homeModules; [
      ada
      aim
      axe
      barium
      brazilcli
      claude-code
      cr
      grasp-tools
      isengard
      kiro
      opencode
      toolbox
    ]);
}
