{ lib', ... }:
{
  home.sessionVariables.TERMINAL = lib'.terminal;

  imports = [
    ./foot.nix
  ];
}
