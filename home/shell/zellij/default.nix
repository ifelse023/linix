_:
{
  programs.zellij = {
    enable = true;
    # package = inputs.zellij.packages.${pkgs.system}.default;
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
}
