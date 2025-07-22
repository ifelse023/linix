{
  environment = {

    variables = {
      FLAKE = "/home/wasd/linix";
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      SYSTEMD_PAGERSECURE = "true";
      PAGER = "less -FR";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
