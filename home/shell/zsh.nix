{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./starship.nix];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    sessionVariables = {LC_ALL = "en_US.UTF-8";};

    history = {
      # share history between different zsh sessions
      share = true;
      # avoid cluttering $HOME with the histfile
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      # saves timestamps to the histfile
      extended = true;
      # optimize size of the histfile by avoiding duplicates
      # or commands we don't need remembered
      save = 1000;
      size = 1000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = ["rm *" "pkill *" "kill *"];
    };
    dirHashes = {
      docs = "$HOME/Documents";
      dev = "$HOME/dev";
      dots = "$HOME/linix";
      dl = "$HOME/Downloads";
    };

    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
      _comp_options+=(globdots)

      # Group matches and describe.
      zstyle ':completion:*' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' rehash true

      # open commands in $EDITOR
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^e" edit-command-line

      zstyle ':completion:*' menu yes select # search
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # Fuzzy match mistyped completions.
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric

      # Don't complete unavailable commands.
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

      # Array completion element sorting.
      zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

      # Colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Jobs id
      zstyle ':completion:*:jobs' numbers true
      zstyle ':completion:*:jobs' verbose true

      # Sort completions
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:files' sort false

    '';

    initExtraFirst = ''

      # C-right / C-left for word skips
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # set my zsh options, first things first
      source ${./opts.zsh}

      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist

      # Colors
      autoload -Uz colors && colors

      # Autosuggest
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      # Vi mode
      bindkey -v

      # Use vim keys in tab complete menu:
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty|kitty*)
        TERM_TITLE=$'\e]0;%n@%m: %1~\a'
          ;;
      *)
          ;;
      esac
    '';

    shellAliases = with pkgs; {
      # make sudo use aliases
      sudo = "sudo ";

      # nix specific aliases
      cleanup = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      curgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      repair = "nix-store --verify --check-contents --repair";
      run = "nix run";
      search = "nix search";
      shell = "nix shell";
      get-drv = "nix eval --raw '.#nixosConfigurations.linix.config.system.build.toplevel.drvPath'";
      build = "nix build .#nixosConfigurations.linix.config.system.build.toplevel";

      cat = "${lib.getExe bat} --style=plain";
      cd = "z";
      grep = "${lib.getExe ripgrep}";
      du = "${lib.getExe du-dust}";
      ps = "${lib.getExe procs}";
      mp = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      # ls = "${lib.getExe eza} -h --git --icons --color=auto -s extension";
      # la = "${lib.getExe eza} -a -h --git --icons --color=auto -s extension";
      # l = "ls -lF --time-style=long-iso --icons";
      # system aliases
      sc = "sudo systemctl";
      jc = "sudo journalctl -b -p err";
      scu = "systemctl --user ";
      jcu = "journalctl --user";
      tree = "${lib.getExe eza} --tree --icons=always";
      http = "${lib.getExe python3} -m http.server";
      burn = "pkill -9";
      diff = "diff --color=auto";
      killall = "pkill";

      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };

    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
    ];
  };
}
