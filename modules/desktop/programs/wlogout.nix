{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.programs.wlogout = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.programs.wlogout {
    home-manager.users.pagu = {
      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "shutdown";
            action = "poweroff";
            text = "Shutdown";
            keybind = "1";
          }
          {
            label = "reboot";
            action = "reboot";
            text = "Restart";
            keybind = "2";
          }
          {
            label = "lock";
            action = "gtklock";
            text = "Lock";
            keybind = "3";
          }
          {
            label = "logout";
            action = "hyprctl exit";
            text = "Logout";
            keybind = "4";
          }
        ];
      };
    };
  };
}
