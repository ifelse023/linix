{
  services.udev = {
    enable = true;
    extraRules =
      ''''
      + (builtins.readFile ./picotool.rules)
      + (builtins.readFile ./40-hpet-permissions.rules)
      + (builtins.readFile ./60-ioschedulers.rules)
      + (builtins.readFile ./99-cpu-dma-latency.rules)
      + (builtins.readFile ./99-platformio-udev.rules);
  };
}
