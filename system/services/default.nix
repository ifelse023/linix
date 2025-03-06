{ pkgs, ... }:

{
  imports = [
    ./power.nix
    ./openssh.nix
    ./location.nix
    ./tty.nix
    ./greetd.nix
  ];

  services = {
    dbus = {
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

    # psd = {
    #   enable = true;
    #   resyncTimer = "60m";
    # };

  };
}
