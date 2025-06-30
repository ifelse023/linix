{
  environment = {

    variables = {
      FLAKE = "/home/wasd/linix";
      SSH_AUTH_SOCK = "/run/user/\${UID}/keyring/ssh";
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      SYSTEMD_PAGERSECURE = "true";
      PAGER = "less -FR";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
