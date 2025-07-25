{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.curl
    pkgs.llvmPackages_21.libllvm
    pkgs.gdb-dashboard
    pkgs.glow
    pkgs.hexyl
    pkgs.libqalculate
    pkgs.gemini-cli
    pkgs.debugedit
    pkgs.file
    pkgs.less
    pkgs.pkg-config
    pkgs.just
    pkgs.just-lsp
    pkgs.picotool
    pkgs.util-linux
    pkgs.sccache
    pkgs.dogdns
    pkgs.procs
    pkgs.hyperfine
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
        enter_accept = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

    eza = {
      enable = true;
      icons = "auto";
      enableNushellIntegration = false;
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--icons"
      ];
    };

    zoxide = {
      enable = true;
    };

  };
}
