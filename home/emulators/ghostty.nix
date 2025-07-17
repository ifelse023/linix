{
  lib,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      font-size = 16;
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
  };
}
