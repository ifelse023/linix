{ pkgs, ... }: {
  # enable completions for system packages
  # and other stuff
  #
  #
  environment = {
    # systemPackages = with pkgs; [
    #   dbus
    # ];

    pathsToLink = [
      "/share/zsh" # zsh completions
      "/share/bash-completion" # bash completions
      "/share/nix-direnv" # direnv completions
    ];

    variables = {
      FLAKE = "/home/wasd/linix";
      SSH_AUTH_SOCK = "/run/user/\${UID}/keyring/ssh";

      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      SYSTEMD_PAGERSECURE = "true";
      PAGER = "less -FR";
      MANPAGER = "nvim +Man!";
    };
  };
}
