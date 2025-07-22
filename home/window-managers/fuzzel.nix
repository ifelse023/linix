{ lib', ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        launch-prefix = "uwsm app --";
        terminal = lib'.terminal + " -e";
        layer = "overlay";
        prompt = "'>>  '";
        icon-theme = "Tela-circle-dracula";
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
