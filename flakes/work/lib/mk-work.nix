# Build a work Home Manager configuration.
#
# Wraps the dotfiles `mkHome` and layers on the common work modules (the amzn
# base module, midway, and the Builder Toolbox tooling). Takes the same
# `{ system, machine }` argument every `machines/*.nix` returns.
#
# Machine functions and modules receive `inputs` (this flake's inputs, so
# `inputs.dotfiles.homeModules` reaches the shared modules), `homeModules`
# (this flake's work modules) and `mcp` (the shared MCP catalogue extended with
# the work servers) as module arguments, injected via `mkHome`'s
# `extraSpecialArgs`.
#
# Note that overriding `inputs` replaces the value the dotfiles flake would
# otherwise inject, so a shared module that referenced `inputs` directly would
# see this flake's inputs instead. None currently do.
{
  inputs,
  mkHome,
  homeModules,
  mcp,
}: args:
(mkHome (args
  // {
    extraSpecialArgs = {inherit inputs homeModules mcp;};
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
