{ config, ... }:
let
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
    "inode/directory" = [ "yazi" ];
  };
in
{
  xdg = {

    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/misc";
      videos = "${config.home.homeDirectory}/misc";
      music = "${config.home.homeDirectory}/misc";
      pictures = "${config.home.homeDirectory}/misc";
      desktop = "${config.home.homeDirectory}/misc";
      publicShare = "${config.home.homeDirectory}/misc";
      templates = "${config.home.homeDirectory}/misc";
      extraConfig = {
        dev = "${config.home.homeDirectory}/dev";
        books = "${config.home.homeDirectory}/misc/books";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
  };
}
