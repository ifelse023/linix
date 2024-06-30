{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine";
    };

    font = {
      name = "JetBrainsMono";
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
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-classic";
      size = 24;
    };

    packages = with pkgs; [
      qt5.qttools
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      breeze-icons
    ];

  };
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "blue" ];
        winDecStyles = [ "modern" ];
      };
    };
  };
}
