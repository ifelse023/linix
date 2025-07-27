_: {
  services.udev = {
    enable = true;
    packages = [
    ];

    extraRules =
      ''''
      + (builtins.readFile ./40-hpet-permissions.rules)
      + (builtins.readFile ./60-ioschedulers.rules)
      + (builtins.readFile ./69-probe-rs.rules)
      + (builtins.readFile ./70-picotool.rules)
      + (builtins.readFile ./99-cpu-dma-latency.rules);
  };
}
