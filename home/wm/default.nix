{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./hyprland
    ./hyprpaper.nix
    ./fuzzel.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
    grim
    slurp
    brightnessctl
    wl-clipboard
    wl-screenrec
    wlr-randr
    libnotify
    cliphist
    xdg-utils
  ];

  systemd.user = {
    services = {
      cliphist = {
        Unit = {
          Description = "Clipboard history service";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
          Restart = "always";
        };

        Install.WantedBy = [ "graphical-session.target" ];
      };

      polkit-gnome-authentication-agent-1 = {
        Unit.Description = "polkit-gnome-authentication-agent-1";

        Install = {
          WantedBy = [ "graphical-session.target" ];
          Wants = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
