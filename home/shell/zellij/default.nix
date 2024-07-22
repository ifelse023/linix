{
  programs.fish = {
    shellAliases = {
      zj = "zellij";
      za = "zellij attach";
    };
  };
  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  programs.zellij = {
    enable = true;
  };
}
