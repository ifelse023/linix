{ pkgs, ... }:
let
  template = pkgs.writers.writePython3Bin "template" {
    flakeIgnore = [
      "E265"
      "E225"
      "E501"
      "E111"
      "E121"
    ];
  } ./template.py;

  replace = pkgs.writers.writeBashBin "replace" ./replace.sh;
in
{

  home.packages = [
    template
    replace
  ];

}
