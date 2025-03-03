{ pkgs, ... }:
# networking configuration
{
  imports = [
    ./security.nix
    ./networkmanager.nix
  ];

  hardware.wirelessRegulatoryDatabase = true;
  # Disable the firewall.
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    ethtool
    # dns client
    dogdns

    wget
    curl
  ];
}
