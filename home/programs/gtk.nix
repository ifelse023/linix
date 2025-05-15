{
  pkgs,
  inputs,
  ...
}:

{

  imports = [ inputs.catppuccin.homeModules.catppuccin ];
  catppuccin = {
    enable = true;
    flavor = "mocha";
    hyprland.enable = false;
    btop.enable = false;
    gtk.enable = false;
    nvim.enable = false;
    cava.enable = false;
    gh-dash.enable = false;
    imv.enable = false;
    swaylock.enable = false;
    sway.enable = false;
    mako.enable = false;
    ghostty.enable = false;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Tela-circle-dracula";
      package = pkgs.tela-circle-icon-theme;
    };
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      size = 12;
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
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      hyprcursor = {
        enable = true;
        size = 24;
      };
    };
    # packages = [
    #   pkgs.qt6Packages.qtstyleplugin-kvantum
    #   pkgs.qt6Packages.qt6ct
    #   pkgs.libsForQt5.qtstyleplugin-kvantum
    #   pkgs.libsForQt5.qt5ct
    # ];
  };
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
