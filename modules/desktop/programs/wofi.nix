{
  config,
  lib,
  ...
}: {
  options.cute.desktop.programs.wofi = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.wofi {
    home-manager.users.pagu = {
      programs.wofi = {
        enable = true;
        settings = {
          hide_scroll = true;
          insensitive = true;
          dynamic_lines = true;
          width = "10%";
          x = 2;
	  location = 0;
          prompt = "";
          lines = 11;
        };
        style = let
	  inherit (config.cute) colours;
	in ''
          window {
              margin: 0px;
              background-color: #${colours.base};
              border-radius: 0px;
              border: 2px solid #${colours.iris};
              color: #e0def4;
              font-family: 'MonaspiceNe Nerd Font';
              font-size: 15px;
          }
          #input {
              margin: 5px;
              border-radius: 0px;
              border: none;
              border-radius: 0px;;
              color: #eb6f92;
              background-color: #${colours.overlay};
          }
          #inner-box {
              margin: 5px;
              border: none;
              background-color: #${colours.overlay};
              color: #191724;
              border-radius: 0px;
          }
          #outer-box {
              margin: 15px;
              border: none;
              background-color: #${colours.base};
          }
          #scroll {
              margin: 0px;
              border: none;
          }
          #text {
              margin: 5px;
              border: none;
              color: #${colours.text};
          }
          #entry:selected {
              background-color: #${colours.iris};
              color: #${colours.base};
              border-radius: 0px;;
              outline: none;
          }
          #entry:selected * {
              background-color: #${colours.iris};
              color: #${colours.base};
              border-radius: 0px;;
              outline: none;
          }
        '';
      };
    };
  };
}
