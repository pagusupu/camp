{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.wm.wlogout = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.wm.wlogout {
    assertions = cutelib.assertHm "wlogout";
    home-manager.users.pagu = {
      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "shutdown";
            action = "poweroff";
          }
          {
            label = "reboot";
            action = "reboot";
          }
          {
            label = "lock";
            action = "gtklock";
          }
          {
            label = "logout";
            action = "hyprctl exit";
          }
        ];
        style = let
          dawn = "rgba(250, 244, 237, 0.8)";
          moon = "rgba(25, 23, 36, 0.8)";
          bg =
            if config.cute.desktop.theme == "light"
            then dawn
            else moon;
          image = name: ''
            #${name} {
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
            }
          '';
        in
          with config.wh.colours;
          #css
            ''
              window {
                background: ${bg};
              }
              button {
                border-radius: 6px;
                border-style: solid;
                border-width: 1px;
                border-color: ${iris};
                margin: 1rem;
              }
              button:active, button:focus {
                background: ${base};
                outline-style: none;
              }
              button:hover {
                background: ${overlay};
              }
              button, button:active, button:focus, button:hover {
                background-repeat: no-repeat;
                background-position: center;
                background-size: 25%;
              }
              ${lib.concatMapStringsSep "\n" image [
                "shutdown"
                "reboot"
                "lock"
                "logout"
              ]}
            '';
      };
    };
  };
}
