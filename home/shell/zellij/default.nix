{ pkgs, inputs, ... }:
{
  programs.zellij = {
    enable = false;
    package = inputs.zellij.packages.${pkgs.system}.default;
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
}
