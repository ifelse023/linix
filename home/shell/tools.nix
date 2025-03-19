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
    just
    pwvucontrol_git
    newt
    picotool
    util-linux
    nix-tree
    sccache
    obsidian
    ethtool
    dogdns
    procs
    wget
    hyperfine
    bintools
    zed-editor
    gping
    sad

    ffmpeg-full

    rsync
    claude-code
    lsof
    psmisc
  ];

  programs = {

    fd = {
      enable = true;
    };

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

    atuin = {
      enable = true;
      # enableFishIntegration = false;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
