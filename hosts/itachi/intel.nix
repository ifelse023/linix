{
  pkgs,
  lib,
  config,
  ...
}:

{
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services = {
    undervolt.enable = false;
    xserver.videoDrivers = lib.mkDefault [ "intel" ];
  };
  services = {
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
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 90;
    };

    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };

  boot = {
    kernel.sysctl = {
      "dev.i915.perf_stream_paranoid" = 0;
    };
    initrd.kernelModules = [
      "i915"
      "kvm-intel"
    ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_dc=0"
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.vaapiIntel
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
      pkgs.intel-compute-runtime-legacy1
    ];
  };
}
