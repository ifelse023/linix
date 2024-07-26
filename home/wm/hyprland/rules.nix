{
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule =
      let
        layers = "^(notifications|kitty|foot|gtk-layer-shell)$";
      in
      [
        "blur, ${layers}"
        "xray 1, ^(bar|gtk-layer-shell)$"
        "ignorealpha 0.2, ${layers}"
        "ignorealpha 0.5, ^(fuzzel)$"
      ];

    windowrule = [
      "float,title:^(Open File)(.*)$"
      "float,title:^(Select a File)(.*)$"
      "float,title:^(Open Folder)(.*)$"
      "float,float,title:^(Save As)(.*)$"
      "float,title:^(Save As)(.*)$"
      "float,title:^(File Upload)(.*)$"
      "float, title:^(.*Bitwarden.*)$"
    ];

    # window rules
    windowrulev2 = [
      "idleinhibit focus,class:kitty"
      "idleinhibit focus,class:foot"
      "idleinhibit focus,class:wezterm"
      "idleinhibit fullscreen, class:^(firefox-nightly)$"

      "float,class:udiskie"

      "float,class:pwvucontrol"
      "float,title:^(Volume Control)$"
      "size 800 600,title:^(Volume Control)$"
      "move 75 44%,title:^(Volume Control)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window).)$"

      "workspace 4 , class:^(firefox-nightly)$"
      "workspace 5, title:^(.*(Disc|WebC)ord.*)$"
      "workspace 1 , class:^(neovide)$"

    ];
    workspace = [
      "1, monitor:eDP-1, default:true"
      "2, monitor:eDP-1, default:true"
      "3, monitor:eDP-1, default:true"
      "4, monitor:HDMI-A-1, default:true"
      "5, monitor:HDMI-A-1, default:true"
    ];
  };
}
