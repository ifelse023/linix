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
in
{
  home.packages = [
    template
  ];
}
