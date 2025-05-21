{
  programs.ssh.startAgent = true;
  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "yes";
        X11Forwarding = false;
        PasswordAuthentication = false;
      };
    };
  };
}
