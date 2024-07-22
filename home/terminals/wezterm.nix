{ pkgs, inputs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = ''
      local wezterm = require "wezterm"
      return {
        check_for_updates = false,
        config.color_scheme = 'Catppuccin Mocha'
        default_cursor_style = 'SteadyBar',
        enable_scroll_bar = true,
        font_size = 10,
        hide_tab_bar_if_only_one_tab = true,
        scrollback_lines = 10000,
      }
    '';
  };
}
