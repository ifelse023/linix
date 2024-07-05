{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkg-config
    zlib

    pkgsx86_64_v3-core.bash
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
      colors = {
        bg = "#1a1b26"; # background color
        "bg+" = "#292e42"; # background color when highlighted
        fg = "#c0caf5"; # foreground color
        "fg+" = "#c0caf5"; # foreground color when highlighted
        hl = "#ff9e64"; # highlight color for matching text
        "hl+" = "#ff9e64"; # highlight color for selected matching text
        info = "#7aa2f7"; # information text color
        prompt = "#7dcfff"; # prompt text color
        pointer = "#7dcfff"; # pointer color at match line
        marker = "#9ece6a"; # marker color for selected items
        spinner = "#9ece6a"; # spinner color
        header = "#9ece6a"; # header color
      };
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--hidden"
        "--glob=!{/proc,*.lock}"

      ];
    };

    atuin = {
      enable = true;
      enableFishIntegration = true;
    };

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
