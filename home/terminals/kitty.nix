{

  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      name = "JetBrains Mono";
    };

    settings = {
      scrollback_lines = 10000;
      placement_strategy = "center";
      allow_remote_control = false;
      disable_ligatures = "never";
      enable_audio_bell = false;
      visual_bell_duration = "0.1";

      copy_on_select = "clipboard";

      selection_foreground = "none";
      selection_background = "none";

      kitty_mod = "alt";

    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "kitty_mod+equal" = "change_font_size all 14.0";
      "kitty_mod+left" = "neighboring_window left";
      "kitty_mod+right" = "neighboring_window right";
      "kitty_mod+down" = "neighboring_window down";
      "kitty_mod+up" = "neighboring_window up";
      "kitty_mod+tab" = "next_tab";
      "kitty_mod+e" = "goto_layout fat";
      "kitty_mod+v" = "goto_layout vertical";
      "kitty_mod+g" = "goto_layout grid";
      "kitty_mod+s" = "goto_layout split";
    };
  };

}
