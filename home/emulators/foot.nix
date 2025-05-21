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
        font = "JetBrains Mono:size=13";
        selection-target = "primary";
      };
      cursor = {
        style = "beam";
        beam-thickness = 2;
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file, gopher, irc, ircs";

        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };
      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "Control+Shift+i";
      };
    };
  };
}
