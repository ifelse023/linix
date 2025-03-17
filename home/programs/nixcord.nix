{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];
  programs.nixcord = {
    enable = true;
    discord.openASAR.enable = false;
    # vesktop.enable = true;
    vesktopConfig = {
      plugins = {
        webKeybinds.enable = true;
        webRichPresence.enable = true;
        webScreenShareFixes.enable = true;
      };
    };
    config = {
      themeLinks = [
        "https://raw.githubusercontent.com/DiscordStyles/SoftX/deploy/SoftX.theme.css"
      ];
      frameless = true;
      disableMinSize = true;

      plugins = {

        showHiddenThings.enable = true;
        showHiddenChannels.enable = true;
        clearURLs.enable = true;
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        fakeNitro.enable = true;
      };
    };
    extraConfig = {
    };
  };
}
