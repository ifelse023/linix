{
  programs.ssh.startAgent = true;
  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "yes";
        PasswordAuthentication = false; # disable password login
      };
    };
  };
}
