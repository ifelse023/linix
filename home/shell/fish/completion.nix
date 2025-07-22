{ pkgs, ... }:
let
  carapace = pkgs.carapace;
  inshellisense = pkgs.inshellisense;
in
{
  home.sessionVariables = {
    "CARAPACE_BRIDGES" = "inshellisense,fish,bash";
  };
  home.packages = [
    inshellisense
    carapace
  ];

  programs.bash.initExtra = ''
    source <(${carapace}/bin/carapace carapace)
  '';

  programs.fish.interactiveShellInit = ''
    ${carapace}/bin/carapace _carapace | source
  '';
  xdg.configFile."fish/completions" = {
    enable = true;
    recursive = true;
    source =
      pkgs.runCommandLocal "carapace-fish-issue-185"
        {
          buildInputs = [
            pkgs.carapace
          ];
        }
        ''
          mkdir $out
          ${carapace}/bin/carapace --list | awk '{ print $1 }' | xargs -I{} touch $out/{}.fish
        '';
  };

}
