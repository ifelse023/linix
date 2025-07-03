{ pkgs, ... }:
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
    dbus = {
      implementation = "broker";
    };
    fwupd.enable = false;
    fstrim.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
  };
  programs.seahorse.enable = true;
}
