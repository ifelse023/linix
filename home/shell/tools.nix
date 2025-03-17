{ pkgs, ... }:

{
  home.packages = with pkgs; [
    curl
    elfutils
    diffutils
    debugedit
    file
    less
    which
    pkg-config
    pwvucontrol_git
    newt
    picotool
    util-linux
    nix-tree
    sccache
    obsidian
    ethtool
    dogdns

    wget
    hyperfine
    bintools
    gping

    fd

    ffmpeg-full

    rsync
    claude-code
    lsof
    psmisc
  ];

  programs = {
    fzf = {
      enable = true;
      defaultCommand = "fd --follow --hidden";
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--hidden"
        "--glob=!{/proc,*.lock,.git}"

      ];
    };

    # atuin = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        whitelist.prefix = [ "~/dev" ];
      };
    };

    eza = {
      enable = true;
      icons = "auto";
      enableNushellIntegration = false;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    zoxide = {
      enable = true;
    };
  };
}
