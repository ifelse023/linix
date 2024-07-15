{
  pkgs,
  inputs,
  lib,
  ...
}:

{

  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    pointerCursor = {
      enable = true;
      accent = "dark";
      flavor = "mocha";
    };
  };
  programs.neovim.catppuccin.enable = lib.mkForce false;

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      accent = "pink";
      flavor = "mocha";
      icon.enable = true;
      icon.accent = "pink";

    };
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  home = {
    packages = with pkgs; [
      qt5.qttools
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
    ];
  };
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

}
