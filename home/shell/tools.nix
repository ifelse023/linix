{ pkgs, inputs, ... }:

let
  v3 = with pkgs.pkgsx86_64_v3-core; [
    curl
    bash
    elfutils
    diffutils
    debugedit
    file
    less
    which
  ];
in
{
  home.packages =
    with pkgs;
    [
      neovide

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
    ]
    ++ v3;

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
    };

  };
}
