{ pkgs, ... }: {
  imports = [
    ./anyrun
    ./hyprland
    ./mako.nix
    ./environment.nix
    ./hyprpaper.nix
    #./hyprlock.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wl-screenrec
    libnotify
    cliphist
    polkit_gnome
    xdg-utils
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals =
      [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  };

  systemd.user = {
    services.cliphist = {
      Unit = {
        Description = "Clipboard history service";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart =
          "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
        Restart = "always";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
    # fake a tray to let apps start
    # https://github.com/nix-community/home-manager/issues/2064
    # targets.tray = {
    #   Unit = {
    #     Description = "Home Manager System Tray";
    #     Requires = [ "graphical-session-pre.target" ];
    #   };
    # };

    services.polkit-gnome-authentication-agent-1 = {
      Unit.Description = "polkit-gnome-authentication-agent-1";
      Install = {
        WantedBy = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
