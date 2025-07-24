{
  environment = {

    variables = {
      FLAKE = "/home/wasd/linix";
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      SYSTEMD_PAGERSECURE = "true";
      MANPAGER = "bat --plain";
      PAGER = "bat --plain";
      MANROFFOPT = "-c";
    };
    shellAliases = {
      cat = "bat";
      less = "bat --plain";
    };
  };
}
