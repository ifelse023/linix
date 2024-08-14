{

  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "wasd" ];
  users.groups.input.members = [ "wasd" ];
  services.xremap = {
    withWlroots = true;
    userName = "wasd";
    serviceMode = "user";
    debug = false;
    watch = false;
    config = {
      keymap = [
        {
          name = "yep";
          application = {
            only = [
              "/vi/"
              "wezterm"
            ];
          };
          remap = {
            "KEY_0" = "Shift-KEY_0";
            "Shift-KEY_0" = "KEY_0";
            "KEY_1" = "Shift-KEY_1";
            "Shift-KEY_1" = "KEY_1";
            "KEY_2" = "Shift-KEY_2";
            "Shift-KEY_2" = "KEY_2";
            "KEY_3" = "Shift-KEY_3";
            "Shift-KEY_3" = "KEY_3";
            "KEY_4" = "Shift-KEY_4";
            "Shift-KEY_4" = "KEY_4";
            "KEY_5" = "Shift-KEY_5";
            "Shift-KEY_5" = "KEY_5";
            "KEY_6" = "Shift-KEY_6";
            "Shift-KEY_6" = "KEY_6";
            "KEY_7" = "Shift-KEY_7";
            "Shift-KEY_7" = "KEY_7";
            "KEY_8" = "Shift-KEY_8";
            "Shift-KEY_8" = "KEY_8";
            "KEY_9" = "Shift-KEY_9";
            "Shift-KEY_9" = "KEY_9";
            "SUPER-KEY_1" = "SUPER-KEY_1";
            "SUPER-KEY_2" = "SUPER-KEY_2";
            "SUPER-KEY_3" = "SUPER-KEY_3";
            "SUPER-KEY_4" = "SUPER-KEY_4";
            "SUPER-KEY_5" = "SUPER-KEY_5";
            "SUPER-KEY_6" = "SUPER-KEY_6";
            "SHIFT-SUPER-KEY_1" = "SHIFT-SUPER-KEY_1";
            "SHIFT-SUPER-KEY_2" = "SHIFT-SUPER-KEY_2";
            "SHIFT-SUPER-KEY_3" = "SHIFT-SUPER-KEY_3";
            "SHIFT-SUPER-KEY_4" = "SHIFT-SUPER-KEY_4";
            "SHIFT-SUPER-KEY_5" = "SHIFT-SUPER-KEY_5";
            "SHIFT-SUPER-KEY_6" = "SHIFT-SUPER-KEY_6";
          };
        }
      ];
    };
  };
}
