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
      confirm_os_window_close = 0;
      placement_strategy = "center";
      allow_remote_control = true;
      focus_follows_mouse = true;
      mouse_hide_wait = 0;
      disable_ligatures = "never";
      enable_audio_bell = false;
      visual_bell_duration = toString 0.1;
      strip_trailing_spaces = "always";
      copy_on_select = "clipboard";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
      window_padding_width = 8;
      scrollback_lines = 100000;
      scrollback_pager = "bat --chop-long-lines";
      clear_all_shortcuts = true;
    };

    keybindings = {
      "ctrl+shift+up" = "increase_font_size";
      "ctrl+shift+down" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
  };
}
