_: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";

    wifi = {
    };
  };

  # wifi = {
  #   macAddress = "random";
  #   powersave = true;
  # };
}
