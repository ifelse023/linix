{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        launch-prefix = "uwsm app --";
        font = "JetBrains Mono";
        terminal = "ghostty";
        layer = "overlay";
        prompt = "'>>  '";
      };
      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "f38ba8ff";
        border = "b4befeff";
      };
      dmenu = {
        exit-immediately-if-empty = "yes";
      };
      border = {
        width = 1;
      };
    };
  };
}
