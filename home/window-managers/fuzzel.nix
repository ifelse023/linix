{ lib', ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        launch-prefix = "uwsm app --";
        font = "JetBrains Mono";
        terminal = lib'.terminal + " -e";
        layer = "overlay";
        prompt = "'>>  '";
        icon-theme = "Tela-circle-dracula";
      };

      colors = {
        background = "1f2335ff";
        text = "c0caf5ff";
        match = "2ac3deff";
        selection = "363d59ff";
        selection-match = "2ac3deff";
        selection-text = "c0caf5ff";
        border = "29a4bdff";
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
