{
  environment = {

    pathsToLink = [
      "/share/bash-completion" # bash completions
      "/share/nix-direnv" # direnv completions
    ];

    variables = {
      FLAKE = "/home/wasd/linix";
      SSH_AUTH_SOCK = "/run/user/\${UID}/keyring/ssh";
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      SYSTEMD_PAGERSECURE = "true";
      PAGER = "less -FR";
      MANPAGER = "hx +Man!";
    };
  };
}
