{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.programs.wofi = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.programs.wofi {
    home-manager.users.pagu = {
      programs.wofi = {
        enable = true;
        settings = {
          hide_scroll = true;
          insensitive = true;
          no_actions = true;
          width = "20%";
          height = "40%";
          y = "-40";
          location = "bottom";
          prompt = "";
          mode = "drun";
          term = "alacritty";
        };
        style = with config.wh.colours;
        #css
          ''
            window {
                margin: 0px;
                background-color: ${base};
                border-radius: 6px;
                border: 2px solid ${love};
                color: ${text};
                font-family: monospace;
                font-size: 16px;
            }
            #input {
                margin: 5px;
                border: none;
                border-radius: 6px;
                color: ${love};
                background-color: ${overlay};
            }
            #inner-box {
                margin: 5px;
                border: none;
                background-color: ${overlay};
                color: ${base};
                border-radius: 6px;
            }
            #outer-box {
                margin: 15px;
                border: none;
                background-color: ${base};
            }
            #scroll {
                margin: 0px;
                border: none;
            }
            #text {
                margin: 5px;
                border: none;
                color: ${text};
            }
            #entry:selected, #entry:selected * {
                background-color: ${love};
                color: ${base};
                border-radius: 6px;
                outline: none;
            }
          '';
      };
    };
  };
}
