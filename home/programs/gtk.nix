{
  pkgs,
  ...
}:

{
  # environment.variables.XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
  # environment.variables.XCURSOR_SIZE = "24";
  # environment.variables.HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors";
  # environment.variables.HYPRCURSOR_SIZE = "24";
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
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
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
