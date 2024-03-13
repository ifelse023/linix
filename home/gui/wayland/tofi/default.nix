{pkgs, ...}: {
  home.packages = [pkgs.tofi];
  xdg.configFile."tofi/config".text = ''
    prompt-text = "> "

    text-color = #cdd6f4
    prompt-color = #585b70
    selection-color = #ff4499
    background-color = #181825dd

    width = 100%
    padding-left = 35%
    padding-top = 20%
    height = 100%
    border-width = 0
    outline-width = 0
    result-spacing = 14
    num-results = 8
    font = JetBrainsMono Nerd Font
    font-variations = "wght 600"
    font-size = 24
  '';
}
