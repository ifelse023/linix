{ pkgs, lib, ... }:

{

  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];
  boot = {
    initrd.kernelModules = [ "i915" ];
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
