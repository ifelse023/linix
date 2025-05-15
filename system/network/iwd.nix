{
  systemd.network = {
    networks."40-wireless" = {
      matchConfig.Name = "wlan0";
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
        IPv6PrivacyExtensions = "kernel";
      };
    };
    wait-online.enable = false;
  };

  networking = {
    useDHCP = true;
    useNetworkd = true;
    usePredictableInterfaceNames = true;

    wireless = {
      iwd = {
        enable = true;
        settings = {
          Settings = {
            AutoConnect = true;
          };
          General = {
            AddressRandomization = "once";
            EnableNetworkConfiguration = false;
          };
          Network = {
            EnableIPv6 = true;
            NameResolvingService = "systemd";
          };
          Scan = {
            DisablePeriodicScan = true;
            DisableRoamingScan = true;
          };
        };
      };
    };
  };

}
