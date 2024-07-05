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
        pad = "10x5 center";
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
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
        protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";

        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };
      colors = {

        foreground = "c0caf5"; # Text
        background = "1a1b26"; # Base
        urls = "73daca"; # URLs

        regular0 = "15161e"; # Surface 1
        regular1 = "f7768e"; # red
        regular2 = "9ece6a"; # green
        regular3 = "e0af68"; # yellow
        regular4 = "7aa2f7"; # blue
        regular5 = "bb9af7"; # maroon
        regular6 = "7dcfff"; # teal
        regular7 = "a9b1d6"; # Subtext 1

        bright0 = "414868"; # Surface 2
        bright1 = "f7768e"; # red
        bright2 = "9ece6a"; # green
        bright3 = "e0af68"; # yellow
        bright4 = "7aa2f7"; # blue
        bright5 = "bb9af7"; # maroon
        bright6 = "7dcfff"; # teal
        bright7 = "c0caf5"; # Subtext 0

        "16" = "ff9e64";
        "17" = "db4b4b";
      };

      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "Control+Shift+i";
      };
    };
  };
}
