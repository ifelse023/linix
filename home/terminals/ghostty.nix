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

      window-padding-x = 6;
      window-padding-y = 8;

      window-decoration = false;

      keybind =
        (lib.mapAttrsToList (name: value: "ctrl+shift+${name}=${value}") {
          c = "copy_to_clipboard";
          v = "paste_from_clipboard";

          z = "jump_to_prompt:-2";
          x = "jump_to_prompt:2";

          j = "scroll_page_lines:1";

          k = "scroll_page_lines:-1";

          home = "scroll_to_top";
          end = "scroll_to_bottom";

          "physical:kp_enter" = "reset_font_size";
          "physical:kp_add" = "increase_font_size:1";
          "physical:kp_subtract" = "decrease_font_size:1";

          t = "new_tab";
          q = "close_surface";

          "physical:one" = "goto_tab:1";
          "physical:two" = "goto_tab:2";
          "physical:three" = "goto_tab:3";
          "physical:four" = "goto_tab:4";
          "physical:five" = "goto_tab:5";
        })
        ++ (lib.mapAttrsToList (name: value: "ctrl+${name}=${value}") {
          "physical:tab" = "next_tab";
          "shift+physical:tab" = "previous_tab";
        });
    };
  };
}
