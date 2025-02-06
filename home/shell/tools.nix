{ pkgs, inputs, ... }:

{
  home.packages =
    with pkgs;
    [
      neovide
    curl
    bash
    elfutils
    diffutils
    debugedit
    file
    less
    which
      pkg-config
      pwvucontrol_git

      nix-tree

      obsidian

      dust

      telescope

      # profiling tool
      hyperfine
      bintools
      gping

      fd

      ffmpeg-full

      # syncthnig for acoustic people
      rsync

      fzf

      lsof
      psmisc
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
      icons = true;
      enableNushellIntegration = false;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
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
      enableNushellIntegration = true;
    };

  };
}
