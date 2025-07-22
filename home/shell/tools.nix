{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.curl
    pkgs.inshellisense
    pkgs.gemini-cli
    pkgs.elfutils
    pkgs.diffutils
    pkgs.debugedit
    pkgs.file
    pkgs.less
    pkgs.which
    pkgs.pkg-config
    pkgs.just
    pkgs.just-lsp
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
    inputs.openocd-rpi.packages.${pkgs.system}.openocd-raspberrypi

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
      options = [ "--cmd cd" ];
    };

  };
}
