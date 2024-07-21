{ pkgs, ... }:
{
  imports = [
    ./power.nix
    ./openssh.nix
    ./location.nix
  ];

  services = {
    keyd = {
      enable = false;
      keyboards.default.extraConfig = ''
        [ids]
        * 

        [main]
        # symbols
        1 = !
        2 = @
        3 = #
        4 = $
        5 = %
        6 = ^
        7 = &
        8 = *
        9 = (
        0 = )

        [shift]
        0 = 0
        1 = 1
        2 = 2
        3 = 3
        4 = 4
        5 = 5
        6 = 6
        7 = 7
        8 = 8
        9 = 9
      '';
    };

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
