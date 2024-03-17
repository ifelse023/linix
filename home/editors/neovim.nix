{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    #plugins = with pkgs.vimPlugins; [
    #];

    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
    ];
  };

  home.packages = with pkgs; [
    neovide
  ];
}
