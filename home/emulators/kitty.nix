{

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      size = 16;
      name = "JetBrains Mono Nerd Font";
    };

    settings = {
      update_check_interval = 0;
      scrollback_lines = 10000;
      confirm_os_window_close = 0;
      placement_strategy = "center";
      allow_remote_control = false;
      disable_ligatures = "never";
      enable_audio_bell = false;
      visual_bell_duration = toString 0.1;
      copy_on_select = "clipboard";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
    };

    keybindings = {
      "kitty_mod+equal" = "change_font_size all 16.0";
      "kitty_mod+left" = "neighboring_window left";
      "kitty_mod+right" = "neighboring_window right";
      "kitty_mod+down" = "neighboring_window down";
      "kitty_mod+up" = "neighboring_window up";
      "kitty_mod+tab" = "next_tab";
      "kitty_mod+e" = "goto_layout fat";
      "kitty_mod+g" = "goto_layout grid";
      "kitty_mod+s" = "goto_layout split";
      "ctrl+shift+up" = "increase_font_size";
      "ctrl+shift+down" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
    };
  };

}
