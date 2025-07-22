{
  lib,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      theme = "cyberdream";
      font-size = 16;
      confirm-close-surface = false;
      gtk-single-instance = true;
      auto-update = "off";

      window-padding-x = 0;
      window-padding-y = 0;
      app-notifications = "no-clipboard-copy";
      window-decoration = false;

      keybind = lib.mapAttrsToList (name: value: "ctrl+shift+${name}=${value}") {
        c = "copy_to_clipboard";
        v = "paste_from_clipboard";

        z = "jump_to_prompt:-2";
        x = "jump_to_prompt:2";

        j = "scroll_page_lines:1";

        k = "scroll_page_lines:-1";

        "physical:kp_enter" = "reset_font_size";
        "physical:kp_add" = "increase_font_size:1";
        "physical:kp_subtract" = "decrease_font_size:1";

      };
    };

    themes = {
      cyberdream = {
        background = "#16181a";
        foreground = "#ffffff";
        cursor-color = "#ffffff";
        selection-background = "#3c4048";
        selection-foreground = "#ffffff";
        palette = [
          "0=#16181a"
          "1=#ff6e5e"
          "2=#5eff6c"
          "3=#f1ff5e"
          "4=#5ea1ff"
          "5=#bd5eff"
          "6=#5ef1ff"
          "7=#ffffff"
          "8=#3c4048"
          "9=#ff6e5e"
          "10=#5eff6c"
          "11=#f1ff5e"
          "12=#5ea1ff"
          "13=#bd5eff"
          "14=#5ef1ff"
          "15=#ffffff"
        ];
      };
    };
  };
}
