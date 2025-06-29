{ lib, config, ... }:

let
  XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
  XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
  XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
  MISC_HOME = "${config.home.homeDirectory}/misc";

  browser = [ "firefox-nightly.desktop" ];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "image/*" = [ "imv.desktop" ];
    "application/json" = browser;

    "text/plain" = [ "hx" ];
    # "inode/directory" = [ "yazi" ];
  };
in

{
  home.sessionVariables = {
    XDG_CACHE_HOME = XDG_CACHE_HOME;
    XDG_CONFIG_HOME = XDG_CONFIG_HOME;
    XDG_DATA_HOME = XDG_DATA_HOME;
    GTK2_RC_FILES = lib.mkForce "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0";
  };

  xdg = {
    enable = true;
    cacheHome = XDG_CACHE_HOME;
    configHome = XDG_CONFIG_HOME;
    dataHome = XDG_DATA_HOME;

    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${config.home.homeDirectory}/Downloads";
      documents = MISC_HOME;
      videos = MISC_HOME;
      music = MISC_HOME;
      pictures = MISC_HOME;
      desktop = MISC_HOME;
      publicShare = MISC_HOME;
      templates = MISC_HOME;

      extraConfig.dev = "${config.home.homeDirectory}/dev";
      extraConfig.books = "${MISC_HOME}/books";
    };

    mimeApps.defaultApplications = associations;
  };
}
