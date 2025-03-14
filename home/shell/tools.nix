{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
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
    newt
    util-linux
    nix-tree
    sccache
    mold-wrapped
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

  xdg.configFile."eza/theme.yml".source = "${inputs.tokyonight}/extras/eza/tokyonight.yml";
}
