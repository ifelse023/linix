{ pkgs, ... }:

{
  imports = [
    ./power.nix
    ./openssh.nix
    ./location.nix
    ./tty.nix
    ./xremap.nix
  ];

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [
        dconf
        gcr
        udisks2
      ];
    };

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    lvm.enable = false;

    psd = {
      enable = true;
      resyncTimer = "60m";
    };

  };
}
