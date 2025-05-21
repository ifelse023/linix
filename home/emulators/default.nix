{ lib', ... }:
{
  home.sessionVariables.TERMINAL = lib'.terminal;

  imports = [
    ./ghostty.nix
  ];
}
