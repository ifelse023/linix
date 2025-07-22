{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.stylix.homeModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/main/extras/base16/cyberdream.yaml";
      sha256 = "1bfi479g7v5cz41d2s0lbjlqmfzaah68cj1065zzsqksx3n63znf";
    };
    polarity = "dark";
    fonts = {
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.borg-sans-mono;
      };
      sansSerif = {
        name = "Inter";
        package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sizes = {
        applications = 11;
        desktop = 11;
      };
    };
    targets = {
      neovim.enable = false;
      firefox.profileNames = [ "hey" ];
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-dracula";
      package = pkgs.tela-circle-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
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

}
