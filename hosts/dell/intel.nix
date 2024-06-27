{ pkgs, inputs, ... }: {
  imports = [ inputs.hardware.nixosModules.common-gpu-intel ];
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "i915.enable_guc=2" ];
  };

  environment.systemPackages = with pkgs; [ intel-gpu-tools ];
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      mesa
    ];
  };
}
