{
  home.file.".config/zellij/layouts/default.kdl" = {
    recursive = true;
    text = ''
      layout {
          default_tab_template {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              children
              pane size=2 borderless=true {
                  plugin location="zellij:status-bar"
              }
          }
          tab
      } '';

  };
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      copy_command = "wl-copy";
      copy_clipboard = "primary";
      scrollback_editor = "nvim";
      plugins = {
        tab-bar = {
          path = "tab-bar";
        };
        status-bar = {
          path = "status-bar";
        };
        strider = {
          path = "strider";
        };
      };
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
  };
}
