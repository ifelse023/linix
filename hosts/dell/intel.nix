{
  pkgs,
  lib,
  config,
  ...
}:

{

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];
  boot = {
    initrd.kernelModules = [
      "i915"
      "kvm-intel"
    ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_guc=3"
      "i915.enable_dc=0"
    ];

  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      vpl-gpu-rt
      libvdpau-va-gl
    ];
  };
}
