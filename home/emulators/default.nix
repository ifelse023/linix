{ lib', ... }:
{
  home.sessionVariables.TERMINAL = lib'.terminal;

  imports = [
    ./kitty.nix
  ];
}
