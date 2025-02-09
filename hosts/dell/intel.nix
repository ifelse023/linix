{ pkgs, lib, ... }:

{

  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "i915.enable_guc=3"
      "enable_fbc=1"
      "i915.enable_dc=0"
    ];

  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  chaotic.mesa-git = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
    ];
    fallbackSpecialisation = false;
  };

}
