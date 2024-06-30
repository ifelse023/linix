{
  programs.kitty = {
    enable = true;
    font = {
      size = 15;
      name = "JetBrainsMono Nerd Font";
    };
    shellIntegration.enableZshIntegration = true;

    settings = {
      font_family = "monospace";
      disable_ligatures = "never";
      scrollback_lines = 10000;
      placement_strategy = "center";
      window_padding_width = 5;
      allow_remote_control = "no";
      enable_audio_bell = "no";
      visual_bell_duration = "0.0";

      selection_foreground = "none";
      selection_background = "none";
    };

    theme = "Catppuccin-Mocha";
  };
}
