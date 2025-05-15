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
    ./scx.nix
  ];

  services = {
    fstrim.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
  };
}
