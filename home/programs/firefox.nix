{ pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    package = pkgs.firefox_nightly;
    policies = {
      DisplayBookmarksToolbar = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableAppUpdate = true;
      Preferences = {
        "browser.toolbars.bookmarks.visibility" = "always";
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
  };
}
