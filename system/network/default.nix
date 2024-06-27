{ pkgs, lib, ... }:
# networking configuration
{
  imports = [ ./security.nix ./networkmanager.nix ];

  systemd.network.wait-online.enable = lib.mkForce false;

  networking = {
    useDHCP = lib.mkForce false;

    useNetworkd = lib.mkForce true;
  };

  hardware.wirelessRegulatoryDatabase = true;

  environment.systemPackages = with pkgs; [
    ethtool

    # dns client
    dogdns

    wget
    curl
  ];
}
