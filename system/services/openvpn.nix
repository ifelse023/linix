{ pkgs, ... }:
{
  services.openvpn.servers = {
    pi = {
      config = ''
        config /home/wasd/misc/pi.ovpn
      '';
      # authUserPass = {
      #   username = (builtins.readFile /persist/secret);
      #   password = lib.removeSuffix "\n" (builtins.readFile /persist/secret);
      # };
      autoStart = false;
      updateResolvConf = true;
    };
  };
  environment.systemPackages = with pkgs; [
    openvpn
    # update-resolv-conf
  ];
}
