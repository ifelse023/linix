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
    cursors = {
      enable = true;
      accent = "dark";
      flavor = "mocha";
    };
    nvim.enable = lib.mkForce false;

    hyprland = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
    };

  };
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
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
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      size = 24;
      hyprcursor = {
        enable = true;
      };
    };
    packages = [
      pkgs.qt6Packages.qtstyleplugin-kvantum
      pkgs.qt6Packages.qt6ct
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.libsForQt5.qt5ct
    ];
  };
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
