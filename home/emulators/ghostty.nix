{
  lib,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 16;
      confirm-close-surface = true;
      gtk-single-instance = true;
      auto-update = "off";

      window-padding-x = 2;
      window-padding-y = 4;
      app-notifications = "no-clipboard-copy";
      window-decoration = false;

      keybind = [
        "alt+enter=new_split:right"
        "alt+;=goto_split:next"
        "alt+'=goto_split:previous"
        "ctrl+enter=new_tab"
        "ctrl+k=close_window"
      ];
    };
  };
}
