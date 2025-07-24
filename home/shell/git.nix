{ config, ... }:
let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMqPLz1VVjaPGsWaeAUnajDs/1awhmQLluvf+J+O9BOa light";
in
{
  programs = {

    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
      # extensions = with pkgs; [
      #   gh-dash # dashboard with pull requests and issues
      #   gh-eco # explore the ecosystem
      #   gh-cal # contributions calender terminal viewer
      # ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    lazygit = {
      enable = true;
    };

    git = {
      enable = true;
      userEmail = "ifelse023@gmail.com";
      userName = "ifelse023";
      lfs.enable = true;

      delta = {
        enable = true;
        options.dark = true;
      };

      ignores = [
        ".cache/"
        ".~lock*"
        ".direnv/"
        "node_modules"
        "result"
        "result-*"
      ];

      extraConfig = {
        init.defaultBranch = "main";
        commit.verbose = true;
        log.date = "iso";
        column.ui = "auto";
        diff.colorMoved = "default";
        merge.conflictstyle = "zdiff3";
        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        color.ui = "auto";
        pull.rebase = true;

        push = {
          default = "current";
          followTags = true;
        };

        rebase = {
          autoSquash = true;
          autoStash = true;
        };
        rerere = {
          autoupdate = true;
          enabled = true;
        };

        commit.gpgsign = true;
        user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile =
            config.home.homeDirectory + "/" + config.xdg.configFile."git/allowed_signers".target;
        };
      };
    };
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${config.programs.git.userEmail} ${publicKey}
  '';
}
