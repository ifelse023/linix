{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./anyrun
    ./hyprland
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
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
    services.cliphist = {
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
    # fake a tray to let apps start
    # https://github.com/nix-community/home-manager/issues/2064
    # targets.tray = {
    #   Unit = {
    #     Description = "Home Manager System Tray";
    #     Requires = [ "graphical-session-pre.target" ];
    #   };
    # };
  };
}
