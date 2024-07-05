{ pkgs, ... }:
# networking configuration
{
  imports = [
    ./security.nix
    ./iwd.nix
  ];

  hardware.wirelessRegulatoryDatabase = true;

  environment.systemPackages = with pkgs; [
    ethtool

    # dns client
    dogdns

    wget
    curl
  ];
}
