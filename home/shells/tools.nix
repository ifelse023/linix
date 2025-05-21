{ pkgs, ... }:

{
  home.packages = [
    pkgs.curl
    pkgs.elfutils
    pkgs.diffutils
    pkgs.debugedit
    pkgs.file
    pkgs.less
    pkgs.which
    pkgs.pkg-config
    pkgs.just
    pkgs.newt
    pkgs.picotool
    pkgs.util-linux
    pkgs.sccache
    pkgs.dogdns
    pkgs.procs
    pkgs.wget
    pkgs.hyperfine
    pkgs.bintools
    pkgs.sad
    pkgs.ffmpeg
    pkgs.rsync
    pkgs.lsof
    pkgs.psmisc
    pkgs.sysstat
    pkgs.pciutils
    pkgs.usbutils
  ];

  programs = {
    fd = {
      enable = true;
      ignores = [ ];
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
      settings = {
        inline_height = 16;
        update_check = false;
        ui = {
          invert = true;
        };
      };
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
        "--icons"
        "--sort extension"
      ];
    };

    zoxide = {
      enable = true;
    };
  };
}
