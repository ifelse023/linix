{ pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        box-drawings-uses-font-glyphs = "yes";
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        shell = "fish";
        term = "xterm-256color";
        font = "JetBrains Mono:size=16";
        selection-target = "primary";
        pad = "4x4 center";
      };
      desktop-notifications = {
        command = "${lib.getExe pkgs.libnotify} -a \${app-id} -i \${app-id} \${title} \${body}";
      };

      cursor = {
        style = "beam";
        beam-thickness = 1;
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
        indicator-position = "relative";
        indicator-format = "line";
      };
      url = {
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      };
      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "Control+Shift+i";
      };
    };
  };
}
