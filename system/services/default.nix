{
  imports = [
    ./udev
    ./sound.nix
    ./keyd.nix
    ./power.nix
    ./openssh.nix
    ./location.nix
    ./tty.nix
    ./greetd.nix
  ];

  services = {
    dbus = {
      implementation = "broker";
      # packages = with pkgs; [
      #   udisks2
      # ];
    };

    fstrim.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

  };
}
