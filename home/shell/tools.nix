{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkg-config

    nix-tree

    dust

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

    fzf

    lsof # list open files
    psmisc # killall/pstree/prtstat/fuser/...
  ];

  programs = {

    fzf = {
      enable = true;
      colors = { };
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--hidden"
        "--glob=!{/proc,*.lock}"

      ];
    };

    # atuin = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
      enableFishIntegration = true;
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

    # man pages for tiktok attention span mfs
    tealdeer = {
      enable = true;
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
