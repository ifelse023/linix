{
  imports = [
    ./security.nix
    ./networkmanager.nix
  ];

  # hardware.wirelessRegulatoryDatabase = true;
  networking.firewall.enable = false;

}
