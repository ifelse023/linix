{ pkgs, ... }: {
  imports = [ ./keyd.nix ./power.nix ./openssh.nix ./seatd.nix ./location.nix ];

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [ dconf gcr udisks2 ];
    };

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    psd = {
      enable = true;
      resyncTimer = "60m";
    };
  };
}
