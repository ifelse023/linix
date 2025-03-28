{ lib, ... }:
{
  home.sessionVariables = {
    FLAKE = "/home/wasd/linix";
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    # SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    DISABLE_QT_COMPAT = "0";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    XDG_CACHE_HOME = lib.mkForce "$HOME/.cache";
    XDG_CONFIG_HOME = lib.mkForce "$HOME/.config";
    XDG_DATA_HOME = lib.mkForce "$HOME/.local/share";
    XDG_BIN_HOME = lib.mkForce "$HOME/.local/bin";
    # To prevent firefox from creating ~/Desktop.
    XDG_DESKTOP_DIR = lib.mkForce "$HOME";
  };
}
