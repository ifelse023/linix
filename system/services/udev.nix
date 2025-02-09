{
  services.udev = {
    enable = true;
    extraRules = ''
      # NVMe SSD
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
      KERNEL=="ntsync", MODE="0644"
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"

      ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
          ATTR{link_power_management_policy}=="*", \
          ATTR{link_power_management_policy}="max_performance"
    '';
  };
}
