{
  lib,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      theme = "tokyonight_night";
      font-size = 16;
      gtk-single-instance = true;
      auto-update = "off";

      window-padding-x = 4;
      window-padding-y = 2;

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

        t = "new_tab";
        q = "close_surface";

      };
    };
  };
}
