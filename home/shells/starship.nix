{ config, lib, ... }:
let
  inherit (builtins) map;
  inherit (lib.strings) concatStrings;
in
{
  home = {
    sessionVariables = {
      STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
    };
  };

  programs.starship =
    let
      elemsConcatted = concatStrings (
        map (s: "\$${s}") [
          "hostname"
          "username"
          "directory"
          "shell"
          "nix_shell"
          "git_branch"
          "git_commit"
          "git_state"
          "git_status"
          "nix"
          "c"
          "python"
          "lua"
          "rust"
          "jobs"
          "cmd_duration"
          "container"
        ]
      );
    in
    {
      enable = true;
      enableFishIntegration = true;

      settings = {
        scan_timeout = 2;
        command_timeout = 100;
        add_newline = false;
        line_break.disabled = false;

        format = "${elemsConcatted}\n$character";

        hostname = {
          ssh_only = true;
          disabled = false;
          format = "@[$hostname](bold #89b4fa) ";
        };

        # configure specific elements
        character = {
          error_symbol = "[[󰋕](bold #f38ba8) ❯](bold #f38ba8)";
          success_symbol = "[[󰋕](bold #a6e3a1) ❯](bold #b4befe)";
          format = "$symbol ";
        };

        username = {
          format = "[$user]($style) in ";
        };

        directory = {
          style = "purple";
          truncation_length = 6;
          read_only_style = "197";
          home_symbol = "󰋜 ~";
          read_only = "  ";
          format = "[ ](bold #a6e3a1) [$path]($style) ";

          substitutions = {
            "~/Dev" = "dev";
            "~/Documents" = "Docs";
          };
        };

        # git
        git_commit.commit_hash_length = 7;
        git_status = {
          ahead = "⇡ ";
          behind = "⇣ ";
          conflicted = " ";
          renamed = "»";
          deleted = "✘ ";
          diverged = "⇆ ";
          modified = "!";
          stashed = "≡";
          staged = "+";
          untracked = "?";
        };

        # language configurations
        # the whitespaces at the end *are* necessary for proper formatting
        nix_shell = {
          symbol = "  ";
          heuristic = true;
        };
        c = {
          detect_files = [ "Makefile" ];
        };

        package.symbol = "  ";
      };
    };
}
