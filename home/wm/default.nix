{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./environment.nix
    ./sway
    ./flameshot.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    wl-screenrec
    wlr-randr
    libnotify
    cliphist
    xdg-utils
    sway-launcher-desktop
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
