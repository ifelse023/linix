{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      material-symbols

      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (google-fonts.override { fonts = [ "Inter" ]; })

      jetbrains-mono

      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    fontconfig.defaultFonts =
      let
        addAll = builtins.mapAttrs (_: v: v ++ [ "Noto Color Emoji" ]);
      in
      addAll {
        serif = [ "Libertinus Serif" ];
        sansSerif = [ "Inter" ];
        monospace = [ "JetBrains Mono Nerd Font" ];
        emoji = [ ];
      };
  };
}
