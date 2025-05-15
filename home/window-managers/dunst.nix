{ pkgs, ... }:
{
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Tela-circle-dracula";
      package = pkgs.tela-circle-icon-theme;
    };
    settings = {
      global = {
        width = "(300, 900)";
        dmenu = "fuzzel --dmenu";
        corner_radius = 6;
        gap_size = 16;
        horizontal_padding = 16;
        padding = 16;
        frame_width = 2;

        alignment = "center";
        font = "Sans 10";
        min_icon_size = 64;

        offset = "0x16";
        origin = "top-center";
      };

      urgency_low = {
        timeout = 5;
      };
      urgency_normal = {
        timeout = 10;
      };
      urgency_critical = {
        timeout = 15;
      };
    };
  };
}
