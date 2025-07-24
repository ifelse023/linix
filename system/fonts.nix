{ pkgs, ... }:
{
  fonts = {
    packages = [
      pkgs.material-symbols
      pkgs.libertinus
      pkgs.noto-fonts

      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-emoji
      pkgs.roboto
      (pkgs.google-fonts.override { fonts = [ "Inter" ]; })
      pkgs.jetbrains-mono
      pkgs.atkinson-hyperlegible-next
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = [ "Atkinson Hyperlegible Next" ];
      sansSerif = [ "Atkinson Hyperlegible Next" ];
      monospace = [ "JetBrains Mono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
