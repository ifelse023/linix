{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    pkg-config
    zlib

    fzf
    bash
    telescope

    # profiling tool
    hyperfine

    # ping, but with cool graph
    gping

    # faster find
    fd

    ffmpeg-full

    # syncthnig for acoustic people
    rsync

    lsof # list open files

    psmisc # killall/pstree/prtstat/fuser/...
  ];

  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    # man pages for tiktok attention span mfs
    tealdeer = {
      enable = false;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };
  };
}
