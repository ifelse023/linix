{ config, lib, ... }:
{

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  services = {
    thermald = {
      enable = lib.mkDefault true;
    };

    tlp.enable = true;
    tlp.settings = {
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MAX_PERF_ON_BAT = 50;
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      # My laptop is always plugged in wherever I'm willing to use it, so I'll
      # value battery lifespan over runtime. Run `tlp fullcharge` to temporarily
      # force full charge.
      # @see https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };

    # battery info
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      cpupower
    ];
  };
}
